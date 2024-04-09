import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../routers/routers_config.dart';

class Application {
  static FluroRouter? router;

  /// push
  static Future? push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      bool maintainState = true,
      bool rootNavigator = false,
      TransitionType? transition,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder,
      RouteSettings? routeSettings}) {
    return router?.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        maintainState: maintainState,
        rootNavigator: rootNavigator,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        routeSettings: routeSettings);
  }

  /// pop
  static pop<T>(BuildContext context, [T? result]) {
    router?.pop(context, result);
  }

  static pushReplaceToSplashPage<T>(BuildContext context, [T? result]) {
    router
        ?.navigateTo(context, Routers.splashPage,
            replace: true, transition: TransitionType.fadeIn, rootNavigator: true, clearStack: true)
        .then((result) {});
  }
}

/// The arguments passed to this route.
///
/// May be used when building the route,
/// when use the arguments in [routeSettings]
class NavigatePushArguments extends Object {
  /// Only preview
  ///
  /// When only preview in [modules] module, set true,
  /// so that custom push and pop.
  bool? isPreview;

  /// Object suitable for all of data.
  Object? arguments;

  NavigatePushArguments({this.isPreview, this.arguments});
}
