import 'package:osstp_network/osstp_network.dart';

import '../model/refresh_page_model.dart';

class RefreshPageSwiperApi extends OsstpRequest<AutoIndexResponseModel> {
  @override
  OsstpOptions? get option => OsstpOptions(
        baseUrl: "http://api.tianapi.com",
      );

  /// 接口
  @override
  get path => "/auto/index";

  @override
  get parameter => {'key': '8d6be0edba1b9edc4ed11353ce494948', 'num': 10};
}
