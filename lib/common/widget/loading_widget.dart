import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingWidget {
  static dismiss({
    bool animation = true,
  }) {
    EasyLoading.dismiss(
      animation: animation,
    );
  }

  static show({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    EasyLoading.show(
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
    EasyLoading.showToast(
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
    EasyLoading.showSuccess(
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
    EasyLoading.showError(
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
    EasyLoading.showInfo(
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
    EasyLoading.showProgress(
      value,
      maskType: maskType,
    );
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
