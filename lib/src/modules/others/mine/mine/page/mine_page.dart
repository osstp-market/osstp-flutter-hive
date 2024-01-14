import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/global/global_variable.dart';
import '/common/widget/osstp_getx_dialog.dart';
import '../../../../../../common/theme/theme.dart';
import '../../../../../../common/utils/badge_utils.dart';
import '../../../../../../common/widget/main_app_bar.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../routers/routers_config.dart';
import '../../../../routers/routers_navigator.dart';
import '../controller/mine_controller.dart';
import '../view/mine_header_view.dart';
import '../view/mine_body_view.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineController>(
      init: MineController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
              title: S.of(context).tabbar_mine,
              rightActionWidgets: [
                const Icon(
                  Icons.notifications_off_rounded,
                ),
                const Icon(
                  Icons.notification_add_rounded,
                )
              ],
              onTapFunction: (OnTapModel tapModel) {
                if (tapModel.index == 0) {
                  BadgeUtils.clear();
                }
                if (tapModel.index == 1) {
                  BadgeUtils.badgeChangeWidget(index: 0, badge: '5');
                  BadgeUtils.badgeChangeWidget(index: 1, badge: '105');
                  BadgeUtils.badgeChangeWidget(index: 2, badge: '55');
                }
              }),
          body: Container(
            color: ThemeColors.scaffoldThemeColor(context),
            child: SafeArea(
              top: false,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.itemList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Obx(() => MineHeaderView(
                              authed: GlobalVariable.auth.value,
                              userInfo: GlobalVariable.userInfo,
                              avatarCallback: () {
                                OsstpDialog.show(
                                  context: context,
                                  config: OsstpDialogConfig(
                                    content: 'Upload ?',
                                    contentTextAlign: TextAlign.center,
                                    showCancelButton: true,
                                    onConfirm: () {},
                                  ),
                                );
                              },
                              notAuthedCallback: () {
                                Application.push(context, Routers.loginPage);
                              },
                              itemCallback: () {
                                Application.push(context, Routers.mineProfilePage);
                              },
                            ))
                        : MineBodyWidget(
                            context: context,
                            index: index - 1,
                            authed: true,
                            itemList: controller.itemList.value,
                            notAuthedCallback: (index) {
                              if (controller.itemList[index].routesName != null) {
                                Application.push(context, controller.itemList[index].routesName!)?.then((result) {});
                              } else {
                                GetXDialog.show(
                                    config: OsstpDialogConfig(
                                  title: "需要认证",
                                  content: "authed = true 时，完成跳转画面",
                                  contentTextAlign: TextAlign.center,
                                ));
                              }
                            },
                            onTapCallback: (index) {
                              if (controller.itemList[index].routesName == null) {
                                GetXDialogDebug(controller.itemList[index].title);
                              } else {
                                Application.push(context, controller.itemList[index].routesName!)?.then((result) {});
                              }
                            },
                          );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
