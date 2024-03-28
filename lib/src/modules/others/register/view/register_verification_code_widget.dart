import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/common/widget/elevated_button_widget.dart';
import '/src/modules/others/register/controller/register_controller.dart';
import 'package:osstp_textfield/osstp_textfield.dart';
import '../../../../../generated/l10n.dart';

class RegisterVerificationCodeWidget extends StatelessWidget {
  const RegisterVerificationCodeWidget({Key? key, required this.registerController}) : super(key: key);
  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OsstpTextFieldRounded(
          editingBorderColor: Colors.green,
          idleBorderColor: Colors.blueGrey,
          borderWidth: 1,
          cornerRadius: 5,
          hintText: S.of(context).login_hint_phone,
          controller: registerController.phoneController,
          focusNode: registerController.phoneNode,
          paddingHorizontal: 0,
          paddingVertical: 0,
          marginHorizontal: 0,
          isCollapsed: false,
          contentPadding: const EdgeInsets.all(10.0),
          counterText: '',
          maxLength: 11,
          maxLengthEnforced: MaxLengthEnforcement.enforced,
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButtonWidget.normal(
                titleText: Text(S.of(context).general_register),
                onPressed: () {
                  registerController.register();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
