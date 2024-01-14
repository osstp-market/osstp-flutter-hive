import 'package:flutter/material.dart';

/// use for List item
///
class InkWellButton extends _InkWellBaseButton {
  /// normal
  const InkWellButton.normal(
      {Key? key,
      required Widget child,
      AlignmentGeometry? alignment,
      EdgeInsetsGeometry? padding,
      double? height,
      double? width,
      Color? backgroundColor,
      required GestureTapCallback onTap,
      GestureTapCallback? onDoubleTap,
      GestureLongPressCallback? onLongPress,
      bool beInkWell = false,
      bool? authed,
      GestureTapCallback? notAuthedCallback})
      : super.base(
          key: key,
          child: child,
          alignment: alignment,
          padding: padding,
          height: height,
          width: width,
          backgroundColor: backgroundColor,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          beInkWell: beInkWell,
          authed: authed,
          notAuthedCallback: notAuthedCallback,
        );

  /// InkWell
  const InkWellButton.InkWell(
      {Key? key,
      required Widget child,
      AlignmentGeometry? alignment,
      EdgeInsetsGeometry? padding,
      double? height,
      double? width,
      Color? backgroundColor,
      required GestureTapCallback onTap,
      GestureTapCallback? onDoubleTap,
      GestureLongPressCallback? onLongPress,
      bool beInkWell = true,
      bool? authed,
      GestureTapCallback? notAuthedCallback})
      : super.base(
          key: key,
          child: child,
          alignment: alignment,
          padding: padding,
          height: height,
          width: width,
          backgroundColor: backgroundColor,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          beInkWell: beInkWell,
          authed: authed,
          notAuthedCallback: notAuthedCallback,
        );
}

/// MaterialButton
class _InkWellBaseButton extends StatelessWidget {
  const _InkWellBaseButton.base(
      {Key? key,
      required this.child,
      this.alignment,
      this.padding,
      this.height,
      this.width,
      this.backgroundColor,
      required this.onTap,
      this.onDoubleTap,
      this.onLongPress,
      this.beInkWell = true,
      this.authed,
      this.notAuthedCallback})
      : assert((authed == null && notAuthedCallback == null) || (authed != null && notAuthedCallback != null),
            "if authed!=null, notAuthedCallback must not null"),
        super(key: key);

  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final GestureTapCallback onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final bool beInkWell;
  final bool? authed;
  final GestureTapCallback? notAuthedCallback;

  // final
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      height: height,
      width: width,
      child: beInkWell
          ? Material(
              key: key,
              color: backgroundColor ?? Colors.transparent,
              child: Ink(
                child: InkWell(
                  onTap: (authed != null && authed == false) ? notAuthedCallback : onTap,
                  onDoubleTap: (authed != null && authed == false) ? notAuthedCallback : onDoubleTap,
                  onLongPress: (authed != null && authed == false) ? notAuthedCallback : onLongPress,
                  child: child,
                ),
              ),
            )
          : Material(
              key: key,
              color: backgroundColor ?? Colors.transparent,
              child: GestureDetector(
                onTap: (authed != null && authed == false) ? notAuthedCallback : onTap,
                onDoubleTap: (authed != null && authed == false) ? notAuthedCallback : onDoubleTap,
                onLongPress: (authed != null && authed == false) ? notAuthedCallback : onLongPress,
                child: child,
              ),
            ),
    );
  }
}
