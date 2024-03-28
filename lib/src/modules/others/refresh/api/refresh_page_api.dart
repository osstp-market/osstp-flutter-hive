import 'dart:convert';
import 'package:osstp_network/osstp_network.dart';

import '../model/refresh_page_model.dart';

const String tianApibaseUrl = "https://apis.tianapi.com";
const Map<String, dynamic> tianParameter = {'key': '8d6be0edba1b9edc4ed11353ce494948', 'num': 20};

class RefreshPageSwiperApi extends OsstpRequest<AutoResponseModel> {
  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/auto/index";

  @override
  get parameter {
    // 深拷贝
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    return temp;
  }
}

class OilpriceApi extends OsstpRequest<OilpriceResponseModel> {
  OilpriceApi({this.province});
  String? province;

  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/oilprice/index";

  @override
  get parameter {
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    temp?.addAll({"prov": province ?? "北京"});
    return temp;
  }
}

class DialogueApi extends OsstpRequest<DialogueResponseModel> {
  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/dialogue/index";

  @override
  get parameter {
    // 深拷贝
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    return temp;
  }
}

class ZhananApi extends OsstpRequest<ZhananResponseModel> {
  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: tianApibaseUrl,
        standardService: false,
      );

  /// 接口
  @override
  get path => "/zhanan/index";

  @override
  get parameter {
    // 深拷贝
    Map<String, dynamic>? temp = json.decode(json.encode(tianParameter));
    return temp;
  }
}
