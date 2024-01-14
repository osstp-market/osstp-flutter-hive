import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/common/widget/elevated_button_widget.dart';
import '/src/modules/others/login/controller/login_controller.dart';
import 'package:osstp_textfield/osstp_textfield.dart';
import '../../../../../generated/l10n.dart';

class LoginPhonePasswordWidget extends StatelessWidget {
  const LoginPhonePasswordWidget({Key? key, required this.loginController, this.loginAction}) : super(key: key);
  final LoginController loginController;
  final VoidCallback? loginAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OsstpTextFieldRounded(
          editingBorderColor: Colors.green,
          idleBorderColor: Colors.black12,
          borderWidth: 1,
          cornerRadius: 5,
          hintText: S.of(context).login_hint_phone,
          controller: loginController.phoneController,
          focusNode: loginController.phoneNode,
          paddingHorizontal: 0,
          paddingVertical: 0,
          marginHorizontal: 0,
          isCollapsed: false,
          contentPadding: const EdgeInsets.all(10.0),
          counterText: '',
          maxLength: 11,
          maxLengthEnforced: MaxLengthEnforcement.enforced,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        OsstpTextFieldRounded(
          editingBorderColor: Colors.green,
          idleBorderColor: Colors.black12,
          borderWidth: 1,
          cornerRadius: 5,
          hintText: S.of(context).login_hint_password,
          controller: loginController.passwordController,
          focusNode: loginController.passwordNode,
          paddingHorizontal: 0,
          paddingVertical: 0,
          marginHorizontal: 0,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(10.0),
          counterText: '',
          maxLength: 20,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButtonWidget.normal(
              titleText: Text(S.of(context).general_login),
              onPressed: () {
                if (loginAction != null) {
                  loginAction!();
                }
              },
            )),
          ],
        ),
      ],
    );
  }
}
