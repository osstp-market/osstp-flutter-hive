import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AutoIndexResponseModel {
  ///
  @JsonProperty(name: 'code')
  int? code;

  ///
  @JsonProperty(name: 'msg')
  String? msg;

  ///
  @JsonProperty(name: 'newslist')
  List<AutoIndexModel>? newslist;
}

@jsonSerializable
class AutoIndexModel {
  ///
  @JsonProperty(name: 'id')
  String? id;

  ///
  @JsonProperty(name: 'ctime')
  String? ctime;

  ///
  @JsonProperty(name: 'title')
  String? title;

  ///
  @JsonProperty(name: 'description')
  String? description;

  ///
  @JsonProperty(name: 'source')
  String? source;

  ///
  @JsonProperty(name: 'picUrl')
  String? picUrl;

  ///
  @JsonProperty(name: 'url')
  String? url;
}
