import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AuthModel {
  @JsonProperty(name: 'expires')
  String? expires;
  @JsonProperty(name: 'token')
  String? token;
}

@jsonSerializable
class UserInfoModel {
  @JsonProperty(name: 'id')
  int? id;
  @JsonProperty(name: 'username')
  String? username;
  @JsonProperty(name: 'mobile')
  String? mobile;
  @JsonProperty(name: 'avatar')
  String? avatar;
  @JsonProperty(name: 'nickname')
  String? nickname;
  @JsonProperty(name: 'introduction')
  String? introduction;
  @JsonProperty(name: 'roles')
  List<UserRoleModel>? roles;
}

@jsonSerializable
class UserRoleModel {
  @JsonProperty(name: 'ID')
  int? roleId;
  @JsonProperty(name: 'CreatedAt')
  String? createdAt;
  @JsonProperty(name: 'UpdatedAt')
  String? updatedAt;
  @JsonProperty(name: 'DeletedAt')
  String? deletedAt;
  @JsonProperty(name: 'name')
  String? name;
  @JsonProperty(name: 'keyword')
  String? keyword;
  @JsonProperty(name: 'desc')
  String? desc;
  @JsonProperty(name: 'status')
  int? status;
  @JsonProperty(name: 'sort')
  int? sort;
  @JsonProperty(name: 'creator')
  String? creator;
  @JsonProperty(name: 'users')
  List<UserRoleModel>? users;
  @JsonProperty(name: 'menus')
  List<UserRoleModel>? menus;
}
