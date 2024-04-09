import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/utils/selected_item_model.dart';
import '../../../../../../generated/l10n.dart';
import '../../../routers/routers_config.dart';

class MineController extends SuperController {
  final logout = ''.obs;

  final itemList = <SelectedItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    initUI();
  }

  initUI() {
    itemList.value = [
      SelectedItemModel(
          title: S.current.setting_about, image: Icons.hive_rounded, routesName: Routers.aboutPage, needSpace: true),
      SelectedItemModel(title: S.current.setting_setting, image: Icons.settings, routesName: Routers.settingHomePage),
    ];

  }

  @override
  void onReady() {
    super.onReady();

    /// 网络请求或者自定义配置item后 重新构建itemList内容
    Future.delayed(const Duration(seconds: 5)).then((value) {
      itemList.refresh();
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
