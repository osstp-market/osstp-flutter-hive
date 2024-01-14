import 'package:osstp_network/osstp_network.dart';
import '../model/captcha_model.dart';
import '../model/user_info_model.dart';

class LoginApi extends OsstpRequest<AuthModel> {
  String username;
  String password;
  LoginApi({required this.username, required this.password});

  @override
  OsstpOptions? get option => OsstpOptions(
        method: RequestMethod.post.method,
        useDefaultParameter: false,
        // shouldDataMock: true,
      );

  @override
  get path => "/base/login";

  @override
  Map<String, dynamic>? get parameter => {
        "username": username,
        "password": password,
      };

  @override
  get dataMock => {"expires": DateTime.now().toString(), "token": "token"};
}

class UserInfoApi extends OsstpRequest<UserInfoModel> {
  @override
  OsstpOptions? get option => OsstpOptions(
        method: RequestMethod.post.method,
        useDefaultParameter: false,
        // shouldDataMock: true,
      );

  @override
  get path => "/user/info";

  @override
  Map<String, dynamic>? get parameter => null;

  @override
  get dataMock => {
        "id": 1,
        "username": "admin",
        "mobile": "18888888888",
        "avatar": "",
        "nickname": "",
        "introduction": "",
        "roles": [
          {
            "ID": 1,
            "CreatedAt": "2023-12-02T12:17:33.106+08:00",
            "UpdatedAt": "2023-12-02T12:17:33.106+08:00",
            "DeletedAt": null,
            "name": "管理员",
            "keyword": "admin",
            "desc": "",
            "status": 1,
            "sort": 1,
            "creator": "系统",
            "users": null,
            "menus": null
          }
        ]
      };
}

class GetCaptcha extends OsstpRequest<CaptchaModel> {
  @override
  OsstpOptions? get option => OsstpOptions(method: RequestMethod.get.method, useDefaultParameter: false);
  @override
  String? get path => "/api/v1/captcha";
}

class LogoutApi extends OsstpRequest {
  @override
  OsstpOptions? get option => OsstpOptions(
        method: RequestMethod.post.method,
        useDefaultParameter: false,
        // shouldDataMock: true,
      );

  @override
  get path => "/base/logout";

  @override
  Map<String, dynamic>? get parameter => null;
}
