import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widget/debug_tag_widget.dart';
import '../../../../../common/config/application_config.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/elevated_button_widget.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../routers/routers_navigator.dart';
import '../../../../../generated/l10n.dart';
import '../../mine/mine/view/mine_body_view.dart';
import '../controller/setting_home_controller.dart';

/// Setting
class SettingHomePage extends StatefulWidget {
  const SettingHomePage({Key? key}) : super(key: key);

  @override
  State<SettingHomePage> createState() => _SettingHomePageState();
}

class _SettingHomePageState extends State<SettingHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SettingHomeController(),
        initState: (state) {},
        builder: (controller) {
          return Scaffold(
            appBar: MainAppBar(title: S.current.setting_setting),
            body: SafeArea(
                top: false,
                child: ListView(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return MineBodyWidget(
                            context: context,
                            index: index,
                            onTapCallback: (callbackIndex) {
                              navigationTo(controller.itemList[callbackIndex].routesName!);
                            },
                            itemList: controller.itemList);
                      },
                      itemCount: controller.itemList.length,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 88.0),
                      padding: const EdgeInsets.all(8.0),
                      child: DebugDisplayTagWidget(
                        fontSize: 50,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButtonWidget.normal(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        S.of(context).setting_reset,
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    onPressed: () {
                                      showGetXGeneralDialog(
                                        content: S.of(context).setting_reset_or_not,
                                        showCancelButton: true,
                                        onConfirm: () async {
                                          bool result = await ApplicationConfig.instance.resetConfig();
                                          if (result == true) {
                                            Application.pushReplaceToSplashPage(context);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "⚠️ ${S.of(context).setting_reset_description}",
                              style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  navigationTo(String router) {
    Application.push(context, router)?.then((result) {});
  }
}
