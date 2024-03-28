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

    String routerName = '';
    for (RouterModel model in routerList) {
      if (router == model.router) {
        routerName = model.routerName;
        break;
      }
    }

    if (logger == true && routerName != '') {
      osstpLogger.d(
          "$event current route: $router\n$event route name: $routerName${itIsEmpty(_routerPage) ? '' : '\npage router: $_routerPage\npage name: ${routerToggleEvent(event, _routerPage, logger: false)}'}");
    }
    return routerName;
  }
}
