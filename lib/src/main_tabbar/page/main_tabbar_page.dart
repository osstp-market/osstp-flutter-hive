import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_badge/osstp_badge.dart';
import 'package:osstp_main_tabbar/osstp_main_tabbar.dart';
import '../../../common/global/global_variable.dart';
import '../../../common/utils/badge_utils.dart';
import '../../../common/utils/show_dialog.dart';

import '../../modules/routers/routers_config.dart';
import '../../modules/routers/routers_page_manager.dart';
import '../controller/main_tabbar_controller.dart';
import '../view/main_tabbar_indexed_stack_view.dart';

class MainTabBarPage extends StatefulWidget {
  const MainTabBarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainTabBarPageState();
}

class _MainTabBarPageState extends State<MainTabBarPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MainTabBarController(),
      initState: (state) {},
      didChangeDependencies: (state) {
        print('didChangeDependencies--');
      },
      didUpdateWidget: (build, state) {
        print('didUpdateWidget--');
      },
      builder: (MainTabBarController controller) {
        return Scaffold(
          body: MainIndexedStackView(
            index: _tabController.index,
            itemCount: controller.tabItemList.length,
            currentItem: (context, index) {
              return controller.tabItemList[index].pageWidget;
            },
          ),
          bottomNavigationBar: Obx(
            () => OsstpMainTabBar(
              badge: BadgeUtils.globalBadge.value,
              badgeDefaultStyle: [OsstpBadgeStyle(index: 2, onlyPoint: true)],
              items: controller.tabItemList.map((e) => e.tabBarItem).toList(),
              type: BottomNavigationBarType.fixed,
              currentIndex: _tabController.index,
              displayIndex: (int index) {
                PageEventManager.routerToggleEvent(initiativeEvent, Routers.mainTabBar,
                    routerPage: controller.tabItemList[index].routesName);
              },
              onTap: (index) {
                setState(() {
                  _tabController.animateTo(index);
                });
              },
              authedValuable: () {
                return GlobalVariable.authState;
              },
              needAuthTabItems: const [0], //[controller.tabItemList.length - 1],
              notAuthedCallback: (index) {
                showGetXGeneralDialog(
                    title: "认证",
                    content: "请注册登录",
                    contentTextAlign: TextAlign.center,
                    showCancelButton: true,
                    confirmTitle: "登录",
                    onConfirm: () {
                      setState(() {
                        _tabController.animateTo(2);
                      });
                    },

                );
              },
            ),
          ),
        );
      },
    );
  }
}
