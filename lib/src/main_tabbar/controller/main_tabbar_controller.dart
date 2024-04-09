import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_main_tabbar/osstp_main_tabbar.dart';
import '../../mine/mine/page/mine_page.dart';
import '../../../../../generated/l10n.dart';
import '../../../info_page.dart';
import '../../routers/routers_config.dart';

class TabBarControllers {
  OsstpMainTabBarItem tabBarItem;
  Widget pageWidget;
  String routesName;

  TabBarControllers({required this.tabBarItem, required this.pageWidget, required this.routesName});
}

class MainTabBarController extends SuperController {
  List<TabBarControllers> tabItemList = [
    TabBarControllers(
      tabBarItem: OsstpMainTabBarItem(label: S.current.tabbar_home, icon: const Icon(Icons.home_rounded)),
      pageWidget: const InfoPage(msg: "Home",),
      routesName: Routers.infoPage,
    ),
    TabBarControllers(
      tabBarItem:
          OsstpMainTabBarItem(label: S.current.tabbar_favor, icon: const Icon(Icons.favorite_rounded), onlyPoint: true),
      pageWidget: const InfoPage(),
      routesName: Routers.infoPage,
    ),
    TabBarControllers(
      tabBarItem: OsstpMainTabBarItem(label: S.current.tabbar_mine, icon: const Icon(Icons.accessibility_rounded)),
      pageWidget: const MinePage(),
      routesName: Routers.infoPage,
    ),
  ];

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。前后台切换时都会执行
        break;
      case AppLifecycleState.paused: // 应用程序不可见，退到后台
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停 彻底退出app 进程彻底禁止
        break;
      case AppLifecycleState.resumed:
        break;
    }
  }
}
