import 'dart:convert';

import '../../../../../src/modules/others/refresh/api/refresh_page_api.dart';
import 'package:osstp_network/osstp_network.dart';
import '../model/clock_model.dart';

const String juheApibaseUrl = "http://apis.juhe.cn";
const Map<String, dynamic> JUHEParameter = {'key': '44b55d0f2029e79598d7f64bf7aeccd7'};

class WeatherApi extends OsstpRequest<WeatherModel> {
  WeatherApi({this.city});
  String? city;

  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: juheApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/simpleWeather/query";

  @override
  get parameter {
    Map<String, dynamic>? temp = json.decode(json.encode(JUHEParameter));
    temp?.addAll({"city": city ?? "大连"});
    return temp;
  }
}

class HolidayApi extends OsstpRequest<HolidayModel> {
  HolidayApi({this.date});
  String? date;

  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/jiejiari/index";

  @override
  get parameter {
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    temp?.addAll({"date": date ?? ""});
    temp?.addAll({"type": 2}); // 查询类型，0批量、1按年、2按月、3范围
    temp?.addAll({"mode": 0}); //查询模式，为1同时返回中外特殊节日信息
    return temp;
  }
}

/// 老黄历
class LunarApi extends OsstpRequest<LunarModel> {
  LunarApi({this.date});
  String? date;

  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/lunar/index";

  @override
  get parameter {
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    temp?.addAll({"date": date ?? ""}); //查询日期，为空默认公历当天
    temp?.addAll({"type": 2}); // 按农历查询该值为1且日期不能有前导零
    return temp;
  }
}

/// 获取当前时间
class BaiduTimeApi extends OsstpRequest {
  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: "http://www.baidu.com",
        standardService: false,
      );
}
