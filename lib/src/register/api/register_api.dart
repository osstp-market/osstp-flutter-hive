import 'package:osstp_network/osstp_network.dart';

import '../../login/model/user_info_model.dart';

class RegisterApi extends OsstpRequest<UserInfoModel> {
  RegisterApi({this.mobile, this.userName, this.password});
  String? mobile;
  String? userName;
  String? password;


  @override
  OsstpOptions? get option => OsstpOptions(
        method: RequestMethod.post.method,
      );

  /// 接口
  @override
  get path => "/base/register";

  @override
  Map<String, dynamic>? get parameter => {"mobile": mobile, "password": password, "username": userName};

  @override
  get dataMock => {
    "id": 1,
    "username": "admin",
    "mobile": "16891879187",
    "avatar": "",
    "nickname": "HIVE",
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
