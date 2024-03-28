import 'package:dart_json_mapper/dart_json_mapper.dart';

/// 汽车新闻
@jsonSerializable
class AutoResponseModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result')
  AutoListModel? result;
}

@jsonSerializable
class AutoListModel {
  @JsonProperty(name: 'curpage')
  int? curpage;
  @JsonProperty(name: 'allnum')
  int? allnum;
  @JsonProperty(name: 'newslist')
  List<AutoItemModel>? newslist;
}

@jsonSerializable
class AutoItemModel {
  @JsonProperty(name: 'id')
  String? id;
  @JsonProperty(name: 'ctime')
  String? ctime;
  @JsonProperty(name: 'title')
  String? title;
  @JsonProperty(name: 'description')
  String? description;
  @JsonProperty(name: 'source')
  String? source;
  @JsonProperty(name: 'picUrl')
  String? picUrl;
  @JsonProperty(name: 'url')
  String? url;
}

/// 汽车油价
@jsonSerializable
class OilpriceResponseModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result')
  OilpriceItemModel? result;
}

@jsonSerializable
class OilpriceItemModel {
  @JsonProperty(name: 'prov')
  String? prov;
  @JsonProperty(name: 'p0')
  String? p0;
  @JsonProperty(name: 'p89')
  String? p89;
  @JsonProperty(name: 'p92')
  String? p92;
  @JsonProperty(name: 'p95')
  String? p95;
  @JsonProperty(name: 'p98')
  String? p98;
  @JsonProperty(name: 'time')
  String? time;
}

/// 经典台词
@jsonSerializable
class DialogueResponseModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result')
  DialogueItemModel? result;
}

@jsonSerializable
class DialogueItemModel {
  @JsonProperty(name: 'dialogue')
  String? dialogue;
  @JsonProperty(name: 'english')
  String? english;
  @JsonProperty(name: 'source')
  String? source;
  @JsonProperty(name: 'type')
  int? type;
}

/// 渣男语录
@jsonSerializable
class ZhananResponseModel {
  @JsonProperty(name: 'code')
  int? code;
  @JsonProperty(name: 'msg')
  String? msg;
  @JsonProperty(name: 'result/content')
  String? content;
}