import 'package:flutter/material.dart';

import '../../../../../common/config/application_config.dart';
import '../../../../../common/utils/localizations_utils.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/divider_line_widget.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../routers/routers_navigator.dart';
import '../../../../../generated/l10n.dart';
import '../../setting/view/setting_action_item.dart';

/// change language
class LocalizationsPage extends StatefulWidget {
  const LocalizationsPage({Key? key}) : super(key: key);

  @override
  State<LocalizationsPage> createState() => _LocalizationsPageState();
}

class _LocalizationsPageState extends State<LocalizationsPage> {
  bool select = false;
  String language = '';
  @override
  void initState() {
    super.initState();

    localeLanguage();
  }

  localeLanguage() async {
    language = await LocalizationsUtils.current.getLocaleDisplayLanguage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: S.of(context).setting_language),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Text("${S.of(context).setting_current_language}：$language"),
          ),
          SettingActionItem(
            title: "中文：",
            selected: true,
            selectedImage: Icons.arrow_forward,
            voidCallback: () async {
              showGetXGeneralDialog(
                content: S.of(context).setting_change_alert,
                showCancelButton: true,
                onConfirm: () async {
                  bool result = await LocalizationsUtils.current.setLanguage(ApplicationConfig.defaultLanguage);
                  if (result == true) {
                    _finishPush();
                  }
                },
              );
            },
          ),
          DividerLineView(),
          SettingActionItem(
            title: "English：",
            selected: true,
            selectedImage: Icons.arrow_forward,
            voidCallback: () async {
              showGetXGeneralDialog(
                content: S.of(context).setting_change_alert,
                showCancelButton: true,
                onConfirm: () async {
                  bool result = await LocalizationsUtils.current.setLanguage(ApplicationConfig.supportLanguage[1]);
                  if (result == true) {
                    _finishPush();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  _finishPush() {
    Application.pushReplaceToSplashPage(context);
  }
}
