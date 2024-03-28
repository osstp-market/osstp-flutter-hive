import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/modules/others/register/view/register_verification_code_widget.dart';

import '../../../../../common/theme/theme.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
            backgroundColor: ThemeColors.scaffoldThemeColor(context),
            elevation: 0.0,
            title: S.of(context).general_register,
          ),
          body: Column(
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
                        child: RegisterVerificationCodeWidget(
                          registerController: controller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
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
                                        style:
                                            const TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
