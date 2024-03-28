import 'package:card_swiper/card_swiper.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:date_format/date_format.dart' as date;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../common/utils/date_format_utils.dart';
import '../../../../../common/utils/show_dialog.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../../../common/utils/string_utils.dart';
import '../api/clock_api.dart';
import '../model/clock_model.dart';
import '../../../../../common/widget/loading_widget.dart';
import '../../../../../generated/l10n.dart';

const String holiday_model_key = "holiday_model_key";
const String future_holiday_model_key = "future_holiday_model_key";
const String weather_model_key = "weather_model_key";
const String weather_request_time_key = "weather_request_time_key";
const String lunar_model_key = "lunar_model_key";
const String format_24_key = "format_24_key";

// 每日更新一次日期，防止篡改系统时间，多次触发API调用
const String datetime_day_key = "datetime_day_key";

enum ApiOperation {
  request,
  cache,
  fetch,
  none,
}

typedef ApiOperationCallback = Function(ApiOperation);
typedef TimeCallback = Function(String);
typedef ApiOperationAndTimeCallback = Function(ApiOperation, DateTime?);

class ClockController extends SuperController {
  final weeks = ['一', '二', '三', '四', '五', '六', '日'];
  final hourUpdate = [];

  final dateTime = DateTime.now().obs;
  final formatHour = 0.obs;
  String formatDateTime24 = date.HH; // 默认24

  final weatherModel = WeatherModel().obs;
  SwiperController loopController = SwiperController();
  final index = 0.obs;
  final futureWeatherList = <FutureModel>[].obs;

  // 保存今日Holiday
  final holidayModel = HolidayModel().obs;
  // 保存未来Holiday
  final futureHolidayModel = HolidayModel().obs;
  final holidayModelList = <HolidayItemModel>[].obs;
  final holidayItemModel = HolidayItemModel().obs;
  final futureHolidayItemModel = HolidayItemModel().obs;

  SwiperController calenderController = SwiperController();
  final lunarModel = LunarModel().obs; //

  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  @override
  void onReady() {
    super.onReady();
    // 构建刷新时间表
    DateTime now = DateTime.now();
    hourUpdate.add(DateTime(now.year, now.month, now.day, 5));
    hourUpdate.add(DateTime(now.year, now.month, now.day, 9));
    hourUpdate.add(DateTime(now.year, now.month, now.day, 13));
    hourUpdate.add(DateTime(now.year, now.month, now.day, 17));
    hourUpdate.add(DateTime(now.year, now.month, now.day, 21));

    _checkAndGetData(true);
  }

  @override
  void onInit() {
    super.onInit();

    format24();

    stopWatchTimer.secondTime.listen((value) {
      if (second() == 0 || second() == 00) {
        updateDateTime();
        _checkAndGetData(false);
      }
    });
    Future.delayed(const Duration(seconds: 1)).then((value) {
      stopWatchTimer.onStartTimer();
    });
  }

  second() {
    return date.formatDate(DateTime.now(), [date.ss]).toInt() ?? 0;
  }

  format24({bool change = false}) {
    bool? format24 = OsstpLocalStorage.fromPrefs(format_24_key, isBoolValue: true);
    if (change == true) {
      if (format24 == null || format24 == true) {
        OsstpLocalStorage.savePrefs(format_24_key, boolValue: false);
        format24 = false;
      } else {
        OsstpLocalStorage.savePrefs(format_24_key, boolValue: true);
        format24 = true;
      }
    }
    formatDateTime24 = format24 == false ? date.hh : date.HH;
    updateDateTime();
  }

  updateDateTime() {
    dateTime.value = DateTime.now();
    formatHour.value = date.formatDate(DateTime.now(), [formatDateTime24]).toInt() ?? 0;
  }

  void _checkAndGetData(bool isInit) {
    _checkOtherByHour(valueCallback: (operation, serverDateTime) {
      _getWeatherData(operation, serverDateTime);
      // 检查一下
      _checkOtherByDay(serverDateTime, valueCallback: (operation) {
        _getLunarData(operation, serverDateTime);
        _getHolidayData(operation, serverDateTime);
      });
    });
  }

  void _getWeatherData(ApiOperation operation, DateTime? serviceDateTime) {
    if (operation == ApiOperation.cache) {
      String? serialize = OsstpLocalStorage.fromPrefs(weather_model_key);
      if (serialize != null) {
        WeatherModel? responseModel = JsonMapper.deserialize<WeatherModel>(serialize);
        weatherModel.value = responseModel ?? WeatherModel();
        List<FutureModel> resultList = [];
        for (FutureModel futureModel in responseModel?.result?.future ?? []) {
          resultList.add(futureModel);
        }
        futureWeatherList.addAllIf(resultList.isNotEmpty, resultList);
      } else {
        _getWeatherData(ApiOperation.request, serviceDateTime);
      }
    } else if (operation == ApiOperation.request) {
      WeatherApi().request().then((result) {
        if (result.success == true) {
          WeatherModel? responseModel = result.data;
          if (responseModel?.reason != null &&
              responseModel!.reason!.contains("查询成功") &&
              responseModel.result != null) {
            weatherModel.value = responseModel;
            String serialize = JsonMapper.serialize(weatherModel.value);
            // 保存调用成功时间
            OsstpLocalStorage.savePrefs(weather_model_key, stringValue: serialize);

            List<FutureModel> resultList = [];
            for (FutureModel futureModel in responseModel.result?.future ?? []) {
              resultList.add(futureModel);
            }
            futureWeatherList.addAllIf(resultList.isNotEmpty, resultList);

            // 保存时间
            WeatherRefreshDateTimeModel model = WeatherRefreshDateTimeModel();
            model.lastRefreshTime = serviceDateTime?.toString();
            for (int i = 0; i < hourUpdate.length; i++) {
              DateTime dateTime = hourUpdate[i];
              if (itIsNotEmpty(serviceDateTime) && dateTime.isAfter(serviceDateTime!)) {
                model.nextRefreshTime = dateTime.toString();
                break;
              } else {
                if (i == hourUpdate.length - 1) {
                  model.nextRefreshTime = hourUpdate.first.toString();
                  break;
                }
              }
            }
            String saveString = JsonMapper.serialize(model);
            OsstpLocalStorage.savePrefs(weather_request_time_key, stringValue: saveString);
          } else {
            LoadingWidget.showError(status: S.current.general_service_data_abnormal);
          }
        } else {
          _getWeatherData(ApiOperation.request, serviceDateTime);
        }
      });
    }
  }

  void _getHolidayData(ApiOperation operation, DateTime? serviceDateTime) {
    if (operation == ApiOperation.cache) {
      String? serialize = OsstpLocalStorage.fromPrefs(holiday_model_key);
      if (serialize != null) {
        HolidayModel? responseModel = JsonMapper.deserialize<HolidayModel>(serialize);
        holidayModel.value = responseModel ?? HolidayModel();
        List<HolidayItemModel> resultList = [];
        for (HolidayItemModel holidayModel in responseModel?.result ?? []) {
          resultList.add(holidayModel);
        }
        holidayModelList.addAllIf(resultList.isNotEmpty, resultList);
        _getNextHoliday(serviceDateTime);
      } else {
        _getHolidayData(ApiOperation.request, serviceDateTime);
      }
    } else if (operation == ApiOperation.request) {
      String dayTime = date.formatDate(serviceDateTime ?? DateTime.now(), DateFormatUtils.ymd);
      HolidayApi(date: dayTime).request().then((result) {
        if (result.success = true) {
          HolidayModel? responseModel = result.data;
          if (responseModel?.code == 200 && responseModel!.result != null) {
            holidayModel.value = responseModel;
            String serialize = JsonMapper.serialize(holidayModel.value);
            OsstpLocalStorage.savePrefs(holiday_model_key, stringValue: serialize);
            _getNextHoliday(serviceDateTime);
          }
        } else {
          _getHolidayData(ApiOperation.request, serviceDateTime);
        }
      });
    }
  }

  void _getFutureHolidayData(ApiOperation operation, DateTime? futureDateTime) {
    if (operation == ApiOperation.fetch) {
      String? serialize = OsstpLocalStorage.fromPrefs(future_holiday_model_key);
      if (serialize != null) {
        HolidayModel? responseModel = JsonMapper.deserialize<HolidayModel>(serialize);
        for (HolidayItemModel item in responseModel?.result ?? []) {
          DateTime? itemDate = DateTime.tryParse(item.date ?? "0");
          DateTime? nowDate = DateTime(futureDateTime!.year, futureDateTime.month, futureDateTime.day);
          if (itemDate != null && itIsNotEmpty(item.name) && itemDate.isAtSameMomentAs(nowDate)) {
            futureHolidayItemModel.value = item;
            break;
          }
        }
        // 本月未来节日为空，获取下一个月的节日
        if (itIsEmpty(futureHolidayItemModel.value.name)) {
          DateTime dayTime = DateTime(futureDateTime!.year, futureDateTime.month + 1, futureDateTime.day);
          _getFutureHolidayData(ApiOperation.request, dayTime);
        }
      } else {
        _getFutureHolidayData(ApiOperation.request, futureDateTime);
      }
    } else if (operation == ApiOperation.request) {
      HolidayApi(date: date.formatDate(futureDateTime!, DateFormatUtils.ymd)).request().then((result) {
        if (result.success = true) {
          HolidayModel? responseModel = result.data;
          if (responseModel?.code == 200 && responseModel!.result != null) {
            for (HolidayItemModel item in responseModel.result ?? []) {
              if (itIsNotEmpty(item.name)) {
                futureHolidayItemModel.value = item;
                String serialize = JsonMapper.serialize(responseModel);
                OsstpLocalStorage.savePrefs(future_holiday_model_key, stringValue: serialize);
                break;
              }
            }
            // 本月未来节日为空，获取下一个月的节日
            if (itIsEmpty(futureHolidayItemModel.value.name)) {
              DateTime dayTime = DateTime(futureDateTime.year, futureDateTime.month + 1, futureDateTime.day);
              _getFutureHolidayData(ApiOperation.request, dayTime);
            }
          }
        } else {
          _getFutureHolidayData(ApiOperation.request, futureDateTime);
        }
      });
    }
  }

  void _getNextHoliday(DateTime? serviceDateTime) {
    DateTime today = serviceDateTime ?? DateTime.now();
    for (HolidayItemModel item in holidayModel.value.result ?? []) {
      DateTime? itemDate = DateTime.tryParse(item.date ?? "0");
      DateTime? nowDate = DateTime(today.year, today.month, today.day);
      if (itemDate != null && itIsNotEmpty(item.name) && itemDate.isAtSameMomentAs(nowDate)) {
        holidayItemModel.value = item;
      }
      if (itemDate != null && itemDate.isAfter(today) && itIsNotEmpty(item.name)) {
        futureHolidayItemModel.value = item;
        break;
      }
    }

    // 本月未来节日为空，获取下一个月的节日
    if (itIsEmpty(futureHolidayItemModel.value.name)) {
      DateTime dayTime = DateTime(today.year, today.month + 1, 1);
      _getFutureHolidayData(ApiOperation.fetch, dayTime);
    }
  }

  _getLunarData(ApiOperation operation, DateTime? serviceDateTime) {
    if (operation == ApiOperation.cache) {
      String? serialize = OsstpLocalStorage.fromPrefs(lunar_model_key);
      if (serialize != null) {
        LunarModel? responseModel = JsonMapper.deserialize<LunarModel>(serialize);
        lunarModel.value = responseModel ?? LunarModel();
      } else {
        _getLunarData(ApiOperation.request, serviceDateTime);
      }
    } else if (operation == ApiOperation.request) {
      String dayTime = date.formatDate(serviceDateTime ?? DateTime.now(), DateFormatUtils.ymd);
      LunarApi(date: dayTime).request().then((result) {
        if (result.success = true) {
          LunarModel? responseModel = result.data;
          if (responseModel?.code == 200 && responseModel!.result != null) {
            lunarModel.value = responseModel;
            String serialize = JsonMapper.serialize(lunarModel.value);
            OsstpLocalStorage.savePrefs(lunar_model_key, stringValue: serialize);
            OsstpLocalStorage.savePrefs(datetime_day_key, stringValue: serviceDateTime?.toString());
          }
        } else {
          _getLunarData(ApiOperation.request, serviceDateTime);
        }
      });
    }
  }

  //
  _checkOtherByHour({ApiOperationAndTimeCallback? valueCallback, bool getNetworkTime = false}) {
    String? localRefreshDateTime = OsstpLocalStorage.fromPrefs(weather_request_time_key);
    WeatherRefreshDateTimeModel? refreshDateTime =
        JsonMapper.deserialize<WeatherRefreshDateTimeModel>(localRefreshDateTime);
    if (itIsEmpty(refreshDateTime) || getNetworkTime == true) {
      // 第一次启动App
      _getDateTimeApi((serverDateTime) {
        if (serverDateTime != null) {
          DateTime? dateTimed = DateTime.tryParse(serverDateTime ?? "");
          // 和服务器日期比较 是否其他日期
          valueCallback!(ApiOperation.request, dateTimed);

          // 优化用户体验
          DateTime reCurrent = DateTime.now();
          if (itIsNotEmpty(dateTimed) &&
              date.formatDate(reCurrent, DateFormatUtils.ymdhn) != date.formatDate(dateTimed!, DateFormatUtils.ymdhn)) {
            showGetXGeneralDialog(title: "⚠️ 警告 ⚠️", content: "请修正设备系统时间，要与网络时间同步");
          }
        } else {
          // 服务器标准时间获取失败
          Future.delayed(const Duration(seconds: 5)).then((value) {
            _checkOtherByHour(valueCallback: valueCallback);
          });
        }
      });
    } else {
      DateTime? last = DateTime.tryParse(refreshDateTime?.lastRefreshTime ?? "");
      DateTime? next = DateTime.tryParse(refreshDateTime?.nextRefreshTime ?? "");

      if (itIsEmpty(last) || itIsEmpty(next)) {
        _checkOtherByHour(valueCallback: valueCallback, getNetworkTime: true);
      } else {
        DateTime current = DateTime.now();
        if (current.isBefore(last!)) {
          showGetXGeneralDialog(title: "⚠️ 警告 ⚠️", content: "请修正设备系统时间，要与网络时间同步");
        } else if (current.isAfter(last) && current.isBefore(next!)) {
          valueCallback!(ApiOperation.cache, current);
        } else if (current.isAfter(next!)) {
          // 已经超过下一个需要请求最新数据
          _getDateTimeApi((serverDateTime) {
            if (serverDateTime != null) {
              DateTime? dateTimed = DateTime.tryParse(serverDateTime ?? "");
              // 优化 和服务器日期比较
              DateTime reCurrent = DateTime.now();
              if (itIsNotEmpty(dateTimed) &&
                  date.formatDate(reCurrent, DateFormatUtils.ymdhn) ==
                      date.formatDate(dateTimed!, DateFormatUtils.ymdhn)) {
                valueCallback!(ApiOperation.request, dateTimed);
              } else {
                showGetXGeneralDialog(title: "⚠️ 警告 ⚠️", content: "请修正设备系统时间，要与网络时间同步");
              }
            } else {
              // 服务器标准时间获取失败
              Future.delayed(const Duration(seconds: 5)).then((value) {
                _checkOtherByHour(valueCallback: valueCallback);
              });
            }
          });
        }
      }
    }
  }

  // 隔天允许请求逻辑
  _checkOtherByDay(DateTime? serviceDateTime, {ApiOperationCallback? valueCallback}) {
    if (serviceDateTime != null) {
      DateTime current = DateTime.now();
      if (current.isBefore(serviceDateTime)) {
        showGetXGeneralDialog(title: "⚠️ 警告 ⚠️", content: "请修正设备系统时间，要与网络时间同步");
      } else {
        // 本地 day 数据
        String? localDateTime = OsstpLocalStorage.fromPrefs(datetime_day_key);
        if (itIsEmpty(localDateTime)) {
          // 第一次
          valueCallback!(ApiOperation.request);
        } else {
          DateTime? localDateDay = DateTime.tryParse(localDateTime?.substring(0, 10) ?? "");
          DateTime? serviceDateDay = DateTime.tryParse(serviceDateTime.toString().substring(0, 10));

          if (itIsNotEmpty(localDateDay) && itIsNotEmpty(serviceDateDay)) {
            if (serviceDateDay!.isBefore(localDateDay!)) {
              showGetXGeneralDialog(title: "⚠️ 警告 ⚠️", content: "请修正设备系统时间，要与网络时间同步");
            } else if (serviceDateDay.isAfter(localDateDay)) {
              valueCallback!(ApiOperation.request);
            } else {
              valueCallback!(ApiOperation.cache);
            }
          }
        }
      }
    }
  }

  // 时间Api
  _getDateTimeApi(ValueChanged valueCallback) {
    BaiduTimeApi().request().then((result) {
      try {
        // 获取响应头中的cookie
        String cookie = result.response!.headers.map['set-cookie'].toString();
        // 使用split方法将Cookie字符串拆分成一个List
        List<String> cookieList = cookie.split('; ');
        // 遍历List，查找并提取PSTM的值
        String? pstmValue = '';
        for (String cookie in cookieList) {
          if (cookie.contains('PSTM')) {
            RegExp regExp = RegExp(r'PSTM=([^;]+)');
            Match? match = regExp.firstMatch(cookie);
            if (match != null && match.groupCount > 0) {
              pstmValue = match.group(1);
              break;
            }
          }
        }
        final timestamp = (int.tryParse(pstmValue!) ?? 0) * 1000; // 转换为毫秒
        valueCallback(DateTime.fromMillisecondsSinceEpoch(timestamp).toString());
      } catch (e) {
        print('e:${e.toString()}');
        valueCallback(null);
      }
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    if (stopWatchTimer.isRunning) {
      stopWatchTimer.onStopTimer();
    }
  }

  @override
  void onResumed() {
    updateDateTime();
    stopWatchTimer.onResetTimer();
    stopWatchTimer.onStartTimer();
  }
}
