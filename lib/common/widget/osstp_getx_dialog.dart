export 'package:osstp_dialog/osstp_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_dialog/osstp_dialog.dart';
import '../global/global_constant.dart';

/// GetX dialog
class GetXDialog {
  static Future<T?> show<T>({
    required OsstpDialogConfig config,

    /// GetX default property
    bool barrierDismissible = false,
    Color? barrierColor,
    bool useSafeArea = true,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    //
    Widget result = OsstpDialogWidgets(
        config: OsstpDialogConfig(
          title: config.title,
          content: config.content,
          contentWidget: config.contentWidget,
          contentTextAlign: config.contentTextAlign,
          onConfirm: config.onConfirm,
          onCancel: config.onCancel,
          showCancelButton: config.showCancelButton,
          // portraitMaxWidthOffset: 0,
          // landscapeMaxWidthOffset: 200,
        ),
        barrierDismissible: barrierDismissible);
    return Get.dialog(
      result,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: globalNavigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }

  ///
  static Future<T?> general<T>({
    /// Gets default property
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color? barrierColor,
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteSettings? routeSettings,
  }) =>
      Get.generalDialog(
          pageBuilder: pageBuilder,
          barrierDismissible: barrierDismissible,
          barrierLabel: barrierLabel,
          transitionDuration: transitionDuration,
          transitionBuilder: transitionBuilder,
          navigatorKey: navigatorKey,
          routeSettings: routeSettings);
}

GetXDialogDebug(String? title) {
  GetXDialog.show(
    config: OsstpDialogConfig(
        title: title,
        showCancelButton: true,
        contentWidget: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Custom content widget',
              textAlign: TextAlign.center,
            ),
            Text(
              'Under construction',
              textAlign: TextAlign.center,
            )
          ],
        )),
  );
}
