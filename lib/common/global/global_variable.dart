import 'package:get/get.dart';

import '../../src/login/model/user_info_model.dart';


class GlobalVariable {
  static final auth = false.obs;
  static String baseUrl = '';
  static Flavor? flavor;

  static get authState {
    if (flavor == Flavor.dev) {
      return true;
    } else {
      return auth.value;
    }
  }

  /// Use for UI display normal
  static get isDebug {
    if (flavor == Flavor.dev) {
      return true;
    } else {
      return false;
    }
  }

  /// Use for UI display normal
  static get isProd {
    if (flavor == Flavor.prod) {
      return true;
    } else {
      return false;
    }
  }

  static UserInfoModel? userInfo;
}

enum Flavor {
  dev,
  sit,
  uat,
  prod,
}
