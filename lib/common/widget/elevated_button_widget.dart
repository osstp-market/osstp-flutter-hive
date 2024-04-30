import 'package:flutter/material.dart';

/// use for Separate buttons
///
class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget.normal({
    Key? key,
    this.titleText,
    this.child,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.disabledColor,
    this.onPressed,
    this.arrowImageName,
    this.arrowImageColor,
    this.padding,
    this.elevation,
    this.borderRadius = 2,
    this.debounceDuration,
  }) : super(key: key);
  final Text? titleText;
  final Widget? child;
  final String? arrowImageName;
  final Color? arrowImageColor;
  final Color? backgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double borderRadius;
  final int? debounceDuration;

  ///
  bool debounce = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: backgroundColor,
        padding: padding,
        disabledForegroundColor: disabledForegroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      ),
      onPressed: () {
        if (debounce == false && onPressed != null) {
          debounce = true;
          onPressed!();
          Future.delayed(Duration(milliseconds: debounceDuration ?? 777), () {
            debounce = false;
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Offstage(
            offstage: titleText == null ? true : false,
            child: titleText,
          ),
          Offstage(
            offstage: child == null ? true : false,
            child: child,
          )
        ],
      ),
    );
  }
}
