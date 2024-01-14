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
  get dataMock => {};
}
