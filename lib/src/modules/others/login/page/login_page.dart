import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/theme/theme.dart';
import '/src/modules/others/login/controller/login_controller.dart';
import '/src/modules/others/login/view/login_phone_password_widget.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../routers/routers_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          // 防止底部被键盘顶起而在键盘上
          resizeToAvoidBottomInset: false,
          appBar: MainAppBar(
            backgroundColor: ThemeColors.scaffoldThemeColor(context),
            elevation: 0.0,
            title: S.of(context).general_login,
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, left: 30, right: 30),
                      child: Text(
                        S.of(context).login_hello,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: ThemeColors.listItemBackgroundThemeColor(context),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: LoginPhonePasswordWidget(
                              loginController: controller,
                              loginAction: () {
                                if (controller.loginCheckState != InputState.success) {
                                  showGetXGeneralDialog(
                                    content: controller.loginCheckState.message,
                                  );
                                } else {
                                  FocusScope.of(context).unfocus();
                                  controller.loginAction((value) {
                                    if (value == true) {
                                      Application.pop(context);
                                    }
                                  });
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                          child: Row(
                            children: [
                              Obx(
                                () => Radio(
                                  value: true,
                                  groupValue: controller.agreeFlag.value,
                                  toggleable: true,
                                  onChanged: (value) {
                                    controller.agreeFlag.value = !controller.agreeFlag.value;
                                  },
                                  activeColor: ThemeColors.radioThemeColor(context),
                                ),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: S.of(context).login_read_agree,
                                          style: TextStyle(color: ThemeColors.richTextThemeColor(context))),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print('用户协议');
                                            },
                                          text: S.of(context).login_user_agree,
                                          style: const TextStyle(
                                              decoration: TextDecoration.underline, color: Colors.blue)),
                                      TextSpan(
                                          text: '  ${S.of(context).login_and}  ',
                                          style: TextStyle(color: ThemeColors.richTextThemeColor(context))),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print('隐私政策');
                                            },
                                          text: S.of(context).login_privacy_policy,
                                          style:
                                              const TextStyle(decoration: TextDecoration.underline, color: Colors.blue))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   child: ,
                //   onTap: () {
                //     controller.getGetCaptcha();
                //   },
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
