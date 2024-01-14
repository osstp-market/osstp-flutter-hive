import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../../common/utils/logger.dart';
import '../../../common/utils/string_utils.dart';
import 'routers_page_manager.dart';

///
class GlobalRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (itIsNotEmpty(route.settings.name)) {
      PageEventManager.routerToggleEvent(didPushEvent, route.settings.name);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (itIsNotEmpty(previousRoute?.settings.name)) {
      PageEventManager.routerToggleEvent(didPopEvent, previousRoute?.settings.name);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (itIsNotEmpty(newRoute?.settings.name)) {
      PageEventManager.routerToggleEvent(didReplaceEvent, newRoute?.settings.name);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (itIsNotEmpty(route.settings.name)) {
      PageEventManager.routerToggleEvent(didRemoveEvent, route.settings.name);
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    if (itIsNotEmpty(previousRoute?.settings.name)) {
      PageEventManager.routerToggleEvent(didStartUserGestureEvent, previousRoute?.settings.name);
    }
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    if (kDebugMode) {
      osstpLoggerNoStack.d('didStopUserGesture');
    }
  }
}
