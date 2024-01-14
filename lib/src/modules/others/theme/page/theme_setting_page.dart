import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import '/common/theme/theme.dart';
import '/common/widget/main_app_bar.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/osstp_getx_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../setting/view/setting_action_item.dart';

/// change theme
class ThemeSettingPage extends StatefulWidget {
  const ThemeSettingPage({Key? key}) : super(key: key);

  @override
  State<ThemeSettingPage> createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  OsstpDynamicThemeMode? themeMode;

  bool darkSelect = true;
  bool followSystem = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0)).then((onValue) {
      initPlatformState();
    });
  }

  /// 初始化获取当前主题类型
  Future<void> initPlatformState() async {
    // 获取主题
    themeMode = await OsstpDynamicTheme.getThemeMode();
    if (themeMode == OsstpDynamicThemeMode.system) {
      followSystem = true;
    } else {
      followSystem = false;
      if (themeMode == OsstpDynamicThemeMode.dark) {
        darkSelect = true;
      } else {
        darkSelect = false;
      }
    }
    setState(() {});
  }

  /// 设置主题类型
  setThemeState(OsstpDynamicThemeMode dynamicThemeMode) {
    themeMode = dynamicThemeMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                   OsstpDynamicThemeWidget.of(context).setThemeMode(dynamicThemeMode: themeMode);
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
                    Switch(
                      activeColor:  Colors.green,
                        value: followSystem,
                        onChanged: (value) async {
                          followSystem = !followSystem;
                          if (followSystem == true) {
                            // 跟随系统时赋值 否则保持原来状态
                            setThemeState(OsstpDynamicThemeMode.system);
                          } else {
                            // 切换时还原到当前设置的主题状态
                            if (await OsstpDynamicTheme.getThemeMode() == OsstpDynamicThemeMode.system) {
                              final brightness = PlatformDispatcher.instance.platformBrightness;
                              darkSelect = brightness == Brightness.dark ? true : false;
                              darkSelect
                                  ? setThemeState(OsstpDynamicThemeMode.dark)
                                  : setThemeState(OsstpDynamicThemeMode.light);
                            } else {
                              if (await OsstpDynamicTheme.getThemeMode() == OsstpDynamicThemeMode.dark) {
                                darkSelect = true;
                                setThemeState(OsstpDynamicThemeMode.dark);
                              } else {
                                darkSelect = false;
                                setThemeState(OsstpDynamicThemeMode.light);
                              }
                            }
                          }
                        })
                  ],
                ),
                Text(
                  S.of(context).setting_system_description,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          !followSystem
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          S.of(context).setting_handle_select,
                          style: const TextStyle(fontSize: 12),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          // 普通模式
                          SettingActionItem(
                            title: S.of(context).setting_normal_type,
                            selected: !darkSelect,
                            voidCallback: () {
                              if (darkSelect == true) {
                                darkSelect = !darkSelect;
                                setThemeState(OsstpDynamicThemeMode.light);
                              }
                            },
                          ),
                          // 暗黑模式
                          SettingActionItem(
                            title: S.of(context).setting_dark_type,
                            selected: darkSelect,
                            voidCallback: () {
                              if (darkSelect == false) {
                                darkSelect = !darkSelect;
                                setThemeState(OsstpDynamicThemeMode.dark);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
