import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routers/routers_navigator.dart';
import '/common/theme/theme.dart';
import '/common/widget/inkWell_button.dart';
import '/src/modules/others/biometric/controller/biometric_controller.dart';
import '../../../../../common/config/application_config.dart';
import '../../../../../common/utils/authentication_utils.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/main_app_bar.dart';

/// auth
class BiometricPage extends StatelessWidget {
  const BiometricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigatePushArguments? arguments = context.settings?.arguments as NavigatePushArguments?;
    return GetBuilder<BiometricController>(
      init: BiometricController(),
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
              automaticallyImplyLeading: arguments?.isPreview ?? false,
              backgroundColor: ThemeColors.scaffoldThemeColor(context),
              elevation: 0.0),
          body: PopScope(
            canPop: arguments?.isPreview ?? false,
            child: SafeArea(
              child: Obx(() => Column(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ApplicationConfig.logoWidget,
                            Center(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                                  child: Text('Current State: ${AuthenticationUtils.instance.authorized.value}')),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: const BoxConstraints(
                                      maxWidth: 300, maxHeight: 300, minHeight: 200, minWidth: 200),
                                  child: InkWellButton.normal(
                                    onTap: () {
                                      AuthenticationUtils.instance.authenticate(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ThemeColors.listItemBackgroundThemeColor(context),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.fingerprint_rounded,
                                                color: ThemeColors.blueColor,
                                                size: 60,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  '点击进行指纹解锁',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWellButton.normal(
                        backgroundColor: ThemeColors.scaffoldThemeColor(context),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "无法认证？",
                            style: TextStyle(color: ThemeColors.linkTextAndLineColor),
                          ),
                        ),
                        onTap: () {
                          showGetXGeneralDialog(

                              content: '重置？',
                              onConfirm: () async {
                                bool result = await ApplicationConfig.instance.resetConfig();
                                if (result == true) {
                                  Application.pushReplaceToSplashPage(context);
                                }
                              },
                              showCancelButton: true,
                              onCancel: () {
                                Application.pop(context);
                              },

                          );
                        },
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
