import 'package:dart_json_mapper/dart_json_mapper.dart';

/// 天气
@jsonSerializable
class WeatherModel {
  @JsonProperty(name: 'reason')
  String? reason;
  @JsonProperty(name: 'result')
  CityWeatherModel? result;
}

///
@jsonSerializable
class CityWeatherModel {
  @JsonProperty(name: 'city')
  String? city;
  @JsonProperty(name: 'realtime')
  RealtimeModel? realtime;
  @JsonProperty(name: 'future')
  List<FutureModel>? future;
}

///
@jsonSerializable
class RealtimeModel {
  @JsonProperty(name: 'temperature')
  String? temperature;
  @JsonProperty(name: 'humidity')
  String? humidity;
  @JsonProperty(name: 'info')
  String? info;
  @JsonProperty(name: 'wid')
  String? wid;
  @JsonProperty(name: 'direct')
  String? direct;
  @JsonProperty(name: 'power')
  String? power;
  @JsonProperty(name: 'aqi')
  String? aqi;
}

@jsonSerializable
class FutureModel {
  @JsonProperty(name: 'date')
  String? date;
  @JsonProperty(name: 'temperature')
  String? temperature;
  @JsonProperty(name: 'weather')
  String? weather;
  @JsonProperty(name: 'wid')
  WidModel? wid;
  @JsonProperty(name: 'direct')
  String? direct;
}

@jsonSerializable
class WidModel {
  @JsonProperty(name: 'day')
  String? day;
  @JsonProperty(name: 'night')
  String? night;
}

/// 节假日
@jsonSerializable
class HolidayModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result/list')
  List<HolidayItemModel>? result;
}

@jsonSerializable
class HolidayItemModel {
  @JsonProperty(name: 'date')
  String? date;
  @JsonProperty(name: 'daycode')
  int? daycode;
  @JsonProperty(name: 'weekday')
  int? weekday;
  @JsonProperty(name: 'cnweekday')
  String? cnweekday;
  @JsonProperty(name: 'lunaryear')
  String? lunaryear;
  @JsonProperty(name: 'lunarmonth')
  String? lunarmonth;
  @JsonProperty(name: 'lunarday')
  String? lunarday;
  @JsonProperty(name: 'info')
  String? info;
  @JsonProperty(name: 'start')
  int? start;
  @JsonProperty(name: 'now')
  int? now;
  @JsonProperty(name: 'end')
  int? end;
  @JsonProperty(name: 'holiday')
  String? holiday;
  @JsonProperty(name: 'name')
  String? name;
  @JsonProperty(name: 'enname')
  String? enname;
  @JsonProperty(name: 'isnotwork')
  int? isnotwork;
  @JsonProperty(name: 'vacation')
  dynamic vacation;
  @JsonProperty(name: 'remark')
  dynamic remark;
  @JsonProperty(name: 'wage')
  int? wage;
  @JsonProperty(name: 'tip')
  String? tip;
  @JsonProperty(name: 'rest')
  String? rest;
}

@jsonSerializable
class LunarModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result')
  LunarItemModel? result;
}

@jsonSerializable
class LunarItemModel {
  @JsonProperty(name: 'gregoriandate')
  String? gregoriandate;
  @JsonProperty(name: 'lunardate')
  String? lunardate;
  @JsonProperty(name: 'lunar_festival')
  String? lunar_festival;
  @JsonProperty(name: 'festival')
  String? festival;
  @JsonProperty(name: 'fitness')
  String? fitness;
  @JsonProperty(name: 'taboo')
  String? taboo;
  @JsonProperty(name: 'shenwei')
  String? shenwei;
  @JsonProperty(name: 'taishen')
  String? taishen;
  @JsonProperty(name: 'chongsha')
  String? chongsha;
  @JsonProperty(name: 'suisha')
  String? suisha;
  @JsonProperty(name: 'wuxingjiazi')
  String? wuxingjiazi;
  @JsonProperty(name: 'wuxingnayear')
  String? wuxingnayear;
  @JsonProperty(name: 'wuxingnamonth')
  String? wuxingnamonth;
  @JsonProperty(name: 'xingsu')
  String? xingsu;
  @JsonProperty(name: 'pengzu')
  String? pengzu;
  @JsonProperty(name: 'jianshen')
  String? jianshen;
  @JsonProperty(name: 'tiangandizhiyear')
  String? tiangandizhiyear;
  @JsonProperty(name: 'tiangandizhimonth')
  String? tiangandizhimonth;
  @JsonProperty(name: 'tiangandizhiday')
  String? tiangandizhiday;
  @JsonProperty(name: 'lmonthname')
  String? lmonthname;
  @JsonProperty(name: 'shengxiao')
  String? shengxiao;
  @JsonProperty(name: 'lubarmonth')
  String? lubarmonth;
  @JsonProperty(name: 'lunarday')
  String? lunarday;
  @JsonProperty(name: 'jieqi')
  String? jieqi;
}

///保存天气刷新时间的
@jsonSerializable
class WeatherRefreshDateTimeModel {
  @JsonProperty(name: 'last_refresh_time')
  String? lastRefreshTime;
  @JsonProperty(name: 'next_refresh_time')
  String? nextRefreshTime;
}
