import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class CaptchaModel {
  ///
  @JsonProperty(name: 'code')
  int? code;

  ///
  @JsonProperty(name: 'msg')
  String? msg;

  ///
  @JsonProperty(name: 'data')
  String? data;

  @JsonProperty(name: 'id')
  String? id;

  ///
  @JsonProperty(name: 'requestId')
  String? requestId;
}
