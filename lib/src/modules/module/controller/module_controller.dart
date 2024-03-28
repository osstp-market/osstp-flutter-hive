import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/utils/selected_item_model.dart';
import '../../routers/routers_config.dart';

class ModuleController extends SuperController {
  List<SelectedItemModel> itemList = [
    SelectedItemModel(title: '启动画面', image: Icons.ad_units_rounded, routesName: Routers.splashPage),
    SelectedItemModel(title: "引导画面", image: Icons.diversity_2_rounded, routesName: Routers.guidePage),
    SelectedItemModel(title: "Badge", image: Icons.notifications_on_rounded, routesName: Routers.badgePage),
    SelectedItemModel(title: "国际化", image: Icons.language, routesName: Routers.localizationsPage),
    SelectedItemModel(title: "暗黑模式", image: Icons.color_lens_outlined, routesName: Routers.themeSettingPage),
    SelectedItemModel(title: "登录", image: Icons.login_rounded, routesName: Routers.loginPage),
    SelectedItemModel(title: "注册", image: Icons.app_registration_rounded, routesName: Routers.registerPage),
    SelectedItemModel(title: "身份认证", image: Icons.safety_check_rounded, routesName: Routers.biometricPage),
    SelectedItemModel(
        title: "通知设定", image: Icons.edit_notifications_rounded, routesName: Routers.notificationSettingPage),
    SelectedItemModel(title: "Refresh Listview", image: Icons.refresh_rounded, routesName: Routers.refreshPage),
    SelectedItemModel(title: "时钟天气", image: Icons.access_time_rounded, routesName: Routers.clockPage),
    SelectedItemModel(title: "设备信息", image: Icons.perm_device_info_rounded, routesName: Routers.deviceInfoPage),
  ].obs;

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
