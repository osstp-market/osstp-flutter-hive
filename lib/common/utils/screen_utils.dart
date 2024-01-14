import 'dart:ui';

double get screenWidth {
  return PlatformDispatcher.instance.views.first.physicalSize.width /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

double get screenHeight {
  return PlatformDispatcher.instance.views.first.physicalSize.height /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}
