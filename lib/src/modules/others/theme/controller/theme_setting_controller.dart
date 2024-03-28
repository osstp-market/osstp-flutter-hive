import 'dart:ui';

import 'package:get/get.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';

enum SelectedThemeType {
  dart,
  light,
  custom,
}

class ThemeSettingController extends SuperController {
  final themeMode = OsstpDynamicThemeMode.system.obs;
  OsstpDynamicThemeMode currentThemeMode = OsstpDynamicThemeMode.system;

  // final darkSelect = SelectedThemeType.light.obs;
  final followSystem = true.obs;

  /// 初始化获取当前主题类型
  Future<void> initPlatformState() async {
    // 获取主题
    themeMode.value = OsstpThemeData.themeMode ?? OsstpDynamicThemeMode.system;
    currentThemeMode = themeMode.value;
    if (themeMode.value == OsstpDynamicThemeMode.system) {
      followSystem.value = true;
    } else {
      followSystem.value = false;
    }
    update();
  }

  changeThemeType() async {
    followSystem.value = !followSystem.value;
    if (followSystem.value == true) {
      // 跟随系统时赋值 否则保持原来状态
      setThemeState(OsstpDynamicThemeMode.system);
    } else {
      OsstpDynamicThemeMode tempThemeMode = await OsstpDynamicTheme.setThemeMode();
      setThemeState(tempThemeMode);
    }
  }

  /// 设置主题类型
  setThemeState(OsstpDynamicThemeMode dynamicThemeMode) {
    themeMode.value = dynamicThemeMode;
    currentThemeMode = themeMode.value;
    refresh();
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 0)).then((onValue) {
      initPlatformState();
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
