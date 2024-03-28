import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/global/global_variable.dart';
import '../../../../../common/utils/selected_item_model.dart';
import '../../../../../common/widget/debug_tag_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../routers/routers_config.dart';

class SettingHomeController extends SuperController {
  final itemList = <SelectedItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    initUI();
  }

  initUI() {
    itemList.value = [
      SelectedItemModel(
          title: S.current.setting_language, image: Icons.language, routesName: Routers.localizationsPage),
      SelectedItemModel(
          title: S.current.setting_theme, image: Icons.color_lens_outlined, routesName: Routers.themeSettingPage),
      SelectedItemModel(
          title: S.current.setting_about,
          image: Icons.description_rounded,
          routesName: Routers.aboutPage,
          needSpace: true),
    ];
    if (GlobalVariable.isDebug) {
      itemList.insert(
        2,
        SelectedItemModel(
          title: S.current.local_auth,
          image: Icons.screen_lock_portrait,
          routesName: Routers.biometricSettingPage,
          needSpace: true,
          child: DebugDisplayTagWidget(),
        ),
      );
    }
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
