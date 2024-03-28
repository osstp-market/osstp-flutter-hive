import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingWidget {
  static dismiss({
    bool animation = true,
  }) {
    return EasyLoading.dismiss(
      animation: animation,
    );
  }

  static show({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static showToast({
    String? status,
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.showToast(
      status ?? "",
      duration: duration,
      toastPosition: toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static showSuccess({
    String? status,
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.showSuccess(
      status ?? "",
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static showError({
    String? status,
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.showError(
      status ?? "",
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static showInfo({
    String? status,
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.showInfo(
      status ?? "",
      duration: duration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  static showProgress(
    double value, {
    EasyLoadingMaskType? maskType,
  }) {
    return EasyLoading.showProgress(
      value,
      maskType: maskType,
    );
  }

  static get displayDuration {
    return EasyLoading.instance.displayDuration;
  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
