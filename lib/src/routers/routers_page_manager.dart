import 'package:osstp_flutter_hive/common/global/global_variable.dart';

import '../../../common/utils/logger.dart';
import '../../../common/utils/string_utils.dart';
import 'routers_config.dart';

const String didPushEvent = 'didPush';
const String didPopEvent = 'didPop';
const String didReplaceEvent = 'didReplace';
const String didRemoveEvent = 'didRemove';
const String didStartUserGestureEvent = 'didStartUserGesture';

/// custom event
const String initiativeEvent = 'initiative';

class PageEventManager {
  static String _routerPage = '';
  static String _tabBarIndexPage = '';

  static String routerToggleEvent(String? event, String? router, {String? routerPage, bool logger = true}) {
    if (routerPage != null) {
      _routerPage = routerPage;
      _tabBarIndexPage = routerPage;
    } else {
      //
      _routerPage = '';
    }
    if (router == Routers.mainTabBar) {
      _routerPage = _tabBarIndexPage;
    }

    String routerName = _getRouterName(router);
    String pageName = _getRouterName(_routerPage);

    if (GlobalVariable.isDebug && logger == true && routerName != '') {
      osstpLogger.d("$event router: $router\n"
          "router name: $routerName"
          "${itIsEmpty(_routerPage) ? '' : '\n'
              'current router: $_routerPage\n'
              'router name: ${itIsEmpty(pageName) ? "[$_routerPage] is not binding screen name" : pageName}'}");
    }
    return routerName;
  }

  static _getRouterName(String? router) {
    String routerName = '';
    for (RouterModel model in routerList) {
      if (router == model.router) {
        routerName = model.routerName;
        break;
      }
    }
    return routerName;
  }
}
