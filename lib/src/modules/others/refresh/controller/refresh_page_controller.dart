import 'package:card_swiper/card_swiper.dart';
import 'package:date_format/date_format.dart' as date;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../../../common/picker/province_picker.dart';
import '../../../../../common/utils/string_utils.dart';
import '../../../../../common/utils/date_format_utils.dart';
import '../../../../../common/utils/shared_preferences_utils.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../common/utils/logger.dart';
import '../../../../../common/widget/loading_widget.dart';
import '../api/refresh_page_api.dart';
import '../model/refresh_page_model.dart';

class RefreshPageController extends SuperController {
  final List<Widget> imagesData = [
    const Icon(
      Icons.flutter_dash_rounded,
      color: Color(0xffF67904),
      size: 160,
    ),
    const Icon(
      Icons.safety_check_rounded,
      color: Color(0xffD12D2E),
      size: 160,
    ),
    const Icon(
      Icons.view_module_rounded,
      color: Color(0xff7A1EA1),
      size: 160,
    ),
    const Icon(
      Icons.free_breakfast_rounded,
      color: Color(0xff1773CF),
      size: 160,
    ),
  ];

  final List<Color> backgroundColors = [
    const Color(0xffF67904),
    const Color(0xffD12D2E),
    const Color(0xff7A1EA1),
    const Color(0xff1773CF)
  ];

  RefreshController refreshController = RefreshController(initialRefresh: true);
  DateTime requestTime = DateTime.now();

  /// 汽车相关
  SwiperController swiperController = SwiperController();
  final newsList = <AutoItemModel>[].obs;
  final index = 0.obs;

  /// 汽油相关
  SwiperController loopController = SwiperController();
  final oilPriceList = <String>[].obs;
  final oilPriceIndex = 0.obs;
  String? oilProvince = "";
  String? oilTime = "";
  String? nextUpdateTime = "";
  List<int> selected = [];

  /// 经典语录相关
  final dialogueResponseModel = DialogueResponseModel().obs;

  // initialRefresh = true 时 不需要主动调用
  void onRefresh() async {
    DateTime currentTime = DateTime.now();
    if (newsList.length < 20 || currentTime.isAfter(requestTime)) {
      RefreshPageSwiperApi().request().then((result) {
        if (result.success == true) {
          AutoResponseModel? responseModel = result.data;
          if (responseModel?.code == 200 && responseModel?.result?.newslist != null) {
            newsList.value = responseModel?.result?.newslist ?? [];
            requestTime = DateTime.now().add(const Duration(minutes: 120));
            newsList.refresh();
            bool resetFooterState = true;
            if (true) {
              // 有更多数据
              // resetFooterState = true;
            } else {
              // 没有更多数据
              // resetFooterState = false;
            }
            refreshController.refreshCompleted(resetFooterState: resetFooterState);
          } else {
            refreshController.refreshFailed();
            LoadingWidget.showError(status: S.current.general_service_data_abnormal);
          }
        } else {
          refreshController.refreshFailed();
          LoadingWidget.showError(status: result.deserialize?.msg?.msg);
        }
      });
    } else {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 2000));
      osstpLogger.w("模拟刷新");
      refreshController.refreshCompleted();
    }
  }

  oilPriceApi({String? province}) async {
    String? request = "";
    if (province != null) {
      request = province;
    } else {
      request = await OsstpLocalStorage.fromPrefs(LocalStoreKey.province);
    }
    OilpriceApi(province: request).request().then((result) {
      if (result.success == true) {
        OilpriceResponseModel? responseModel = result.data;
        if (responseModel?.code == 200 && responseModel?.result != null) {
          OsstpLocalStorage.savePrefs(LocalStoreKey.province, stringValue: responseModel?.result?.prov ?? "");
          selected = [getProvinceSelected(responseModel?.result?.prov ?? "")];
          // 92号汽油 95号汽油 98号汽油 0号柴油
          List<String> resultList = [];
          if (itIsNotEmpty(responseModel?.result?.p0)) {
            resultList.add("92号汽油 ${responseModel?.result?.p92}元");
          }
          // 92号汽油 95号汽油 98号汽油 0号柴油
          if (itIsNotEmpty(responseModel?.result?.p0)) {
            resultList.add("95号汽油 ${responseModel?.result?.p95}元");
          }
          // 92号汽油 95号汽油 98号汽油 0号柴油
          if (itIsNotEmpty(responseModel?.result?.p0)) {
            resultList.add("98号汽油 ${responseModel?.result?.p98}元");
          }
          // 92号汽油 95号汽油 98号汽油 0号柴油
          if (itIsNotEmpty(responseModel?.result?.p0)) {
            resultList.add("0号柴油 ${responseModel?.result?.p0}元");
          }
          if (itIsNotEmpty(responseModel?.result?.p0)) {
            resultList.add("下次调价 ${_nextUpdateDateTime()}");
          }
          oilProvince = responseModel?.result?.prov;
          DateTime? dateTime = DateTime.tryParse(responseModel?.result?.time ?? "");
          if (dateTime != null) {
            oilTime = date.formatDate(dateTime, DateFormatUtils.ymd);
          } else if (itIsNotEmpty(responseModel?.result?.time) && responseModel!.result!.time!.length >= 10) {
            oilTime = responseModel.result!.time!.substring(0, 10);
          } else {
            oilTime = responseModel?.result?.time ?? '';
          }
          oilPriceList.addAllIf(resultList.isNotEmpty, resultList);
        } else {
          LoadingWidget.showError(status: S.current.general_service_data_abnormal);
        }
      } else {
        LoadingWidget.showError(status: result.deserialize?.msg?.msg);
      }
    });
  }

  dialogueApi() {
    DialogueApi().request().then((result) {
      if (result.success == true) {
        DialogueResponseModel? responseModel = result.data;
        if (responseModel?.code == 200 && responseModel?.result != null) {
          dialogueResponseModel.update((val) {
            val?.result = responseModel?.result;
          });
        } else {
          LoadingWidget.showError(status: S.current.general_service_data_abnormal);
        }
      }
    });
  }

  zhananApi() {
    ZhananApi().request().then((result) {
      if (result.success == true) {
        ZhananResponseModel? responseModel = result.data;
        if (responseModel?.code == 200 && responseModel?.content != null) {
          requestTime = DateTime.now().add(const Duration(minutes: 120));
          print(responseModel?.content);
        }
      }
    });
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadNoData();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    oilPriceApi();
    // dialogueApi();
    // zhananApi();
  }

  _nextUpdateDateTime() {
    DateTime dateTime = DateTime.now();
    for (String my in updateMD) {
      int? month = my.split("-").first.toInt();
      int day = my.split("-").last.toInt() ?? 0;
      if (month == dateTime.month && dateTime.day <= day) {
        DateTime updateDay = DateTime(dateTime.year, dateTime.month, day);
        nextUpdateTime = "${date.formatDate(updateDay, DateFormatUtils.ymd)} 24时";
        break;
      }
      if (itIsNotEmpty(month) && month! > dateTime.month) {
        DateTime updateDay = DateTime(dateTime.year, month, day);
        nextUpdateTime = "${date.formatDate(updateDay, DateFormatUtils.ymd)} 24时";
        break;
      }
    }
    return nextUpdateTime;
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}

List updateMD = [
  "1-3",
  "1-17",
  "1-31",
  "2-19",
  "3-4",
  "3-18",
  "4-1",
  "4-16",
  "4-29",
  "5-15",
  "5-29",
  "6-13",
  "6-27",
  "7-11",
  "7-25",
  "8-8",
  "8-22",
  "9-5",
  "9-20",
  "10-10",
  "10-23",
  "11-6",
  "11-20",
  "12-4",
  "12-18",
];
