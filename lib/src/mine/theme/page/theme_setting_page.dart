import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import '../../../../../common/widget/elevated_button_widget.dart';
import '../../../routers/routers_config.dart';
import '../../../routers/routers_navigator.dart';
import '../../../../../common/widget/divider_line_widget.dart';
import '../controller/theme_setting_controller.dart';
import '../../../../../common/theme/theme.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../setting/view/setting_action_item.dart';

/// change theme
class ThemeSettingPage extends StatefulWidget {
  const ThemeSettingPage({Key? key}) : super(key: key);

  @override
  State<ThemeSettingPage> createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSettingController>(
      init: ThemeSettingController(),
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
            title: S.of(context).setting_theme,
            rightActionWidgets: [
              ElevatedButton(
                // style: const ButtonStyle(),
                child: Text(S.of(context).general_save),
                onPressed: () {
                  showGetXGeneralDialog(
                    content: S.of(context).setting_change_alert,
                    showCancelButton: true,
                    onConfirm: () async {
                      OsstpDynamicThemeWidget.of(context).saveThemeMode(dynamicThemeMode: controller.currentThemeMode);
                    },
                  );
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              Container(
                color: ThemeColors.listItemBackgroundThemeColor(context),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 跟随系统
                        Text(S.of(context).setting_default_system),
                        Obx(
                          () => Switch(
                            activeColor: Colors.green,
                            value: controller.followSystem.value,
                            onChanged: (value) async {
                              controller.changeThemeType();
                            },
                          ),
                        )
                      ],
                    ),
                    Text(
                      S.of(context).setting_system_description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              !controller.followSystem.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            S.of(context).setting_handle_select,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Obx(() => Column(
                                children: [
                                  // 普通模式
                                  SettingActionItem(
                                    title: S.of(context).setting_normal_type,
                                    selected: controller.themeMode.value == OsstpDynamicThemeMode.light,
                                    voidCallback: () {
                                      controller.setThemeState(OsstpDynamicThemeMode.light);
                                    },
                                  ),
                                  DividerLineView(),
                                  // 暗黑模式
                                  SettingActionItem(
                                    title: S.of(context).setting_dark_type,
                                    selected: controller.themeMode.value == OsstpDynamicThemeMode.dark,
                                    voidCallback: () {
                                      controller.setThemeState(OsstpDynamicThemeMode.dark);
                                    },
                                  ),
                                  DividerLineView(),
                                  SettingActionItem(
                                    title: S.of(context).setting_custom_theme,
                                    selected: controller.themeMode.value == OsstpDynamicThemeMode.custom,
                                    voidCallback: () async {
                                      Application.push(context, Routers.colorPickerPagePage,
                                              routeSettings:
                                                  RouteSettings(arguments: OsstpThemeData.customThemeColorModel))
                                          ?.then((value) async {
                                        if (value != null) {
                                          ThemeColorModel result = value;
                                          bool saved = await OsstpThemeData.saveCustomThemeData(
                                            themeColorModel: ThemeColorModel(
                                              brightness: result.brightness,
                                              primaryColor: result.primaryColor,
                                              appBarAndBottomBarThemeColor: result.appBarAndBottomBarThemeColor,
                                              scaffoldBackgroundColor: result.scaffoldBackgroundColor,
                                              selectedIconThemeColor: result.selectedIconThemeColor,
                                              unselectedIconThemeColor: result.unselectedIconThemeColor,
                                              selectedItemColor: result.selectedItemColor,
                                              unselectedItemColor: result.unselectedItemColor,
                                              primaryColorLightColor: result.primaryColorLightColor,
                                              dividerColor: result.dividerColor,
                                              iconThemeColor: result.iconThemeColor,
                                              elevatedButtonThemeColor: result.elevatedButtonThemeColor,
                                            ),
                                          );
                                          if (saved == true) {
                                            OsstpDynamicThemeWidget.of(context)
                                                .saveThemeMode(dynamicThemeMode: OsstpDynamicThemeMode.custom);
                                            OsstpDynamicThemeWidget.of(context)
                                                .setTheme(customTheme: OsstpThemeData.customThemeData);
                                            controller.setThemeState(OsstpDynamicThemeMode.custom);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  if (controller.themeMode.value == OsstpDynamicThemeMode.custom)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButtonWidget.normal(
                                              titleText: const Text("Random Theme"),
                                              onPressed: () {
                                                OsstpDynamicThemeWidget.of(context).saveThemeMode();
                                                controller.currentThemeMode = OsstpThemeData.themeMode!;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              )),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
