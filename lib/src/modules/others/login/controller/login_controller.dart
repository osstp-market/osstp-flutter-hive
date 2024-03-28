import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/common/utils/string_utils.dart';
import '/common/widget/loading_widget.dart';
import '/src/modules/others/login/api/login_api.dart';
import 'package:osstp_network/osstp_network.dart';
import '../../../../../common/global/global_variable.dart';
import '../../../../../common/utils/crypto_utils.dart';
import '../../../../../common/utils/show_dialog.dart';
import '../../../../../common/widget/osstp_getx_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../model/captcha_model.dart';

enum InputState {
  phoneEmpty,
  passwordEmpty,
  policyEmpty,
  success,
}

extension InputStateError on InputState {
  String get message {
    switch (this) {
      case InputState.phoneEmpty:
        return S.current.login_hint_phone;
      case InputState.passwordEmpty:
        return S.current.login_hint_password;
      case InputState.policyEmpty:
        return S.current.login_agree_policy;
      case InputState.success:
        return '';
    }
  }
}

class LoginController extends SuperController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  final imageData = Uint8List(0).obs;
  final agreeFlag = false.obs;

  final int duration = 10;
  bool captchaEnable = true;

  @override
  void onInit() {
    super.onInit();
    // phoneController.text = "admin";
    // passwordController.text = "123456";
  }

  getGetCaptcha() {
    GetCaptcha().request().then((value) {
      CaptchaModel? captchaModel = value.deserialize?.data;
      if (itIsNotEmpty(captchaModel?.data)) {
        imageData.value = base64.decode(captchaModel!.data!.split(',').last);
      }
    });
  }

  InputState get loginCheckState {
    if (itIsEmpty(phoneController.text)) {
      return InputState.phoneEmpty;
    }
    if (itIsEmpty(passwordController.text)) {
      return InputState.passwordEmpty;
    }
    if (agreeFlag.value == false) {
      return InputState.policyEmpty;
    }
    return InputState.success;
  }

  loginAction(ValueChanged<bool> valueChanged) async {
    String crypto = await cryptoByPem(passwordController.text);
    LoadingWidget.show();
    LoginApi(username: phoneController.text, password: crypto).request().then((result) {
      if (result.success == true) {
        OsstpOptionsConfig.instance.headers = {"Authorization": "Bearer ${result.data?.token}"};
        //
        getUserInfo(valueChanged);
      } else {
        LoadingWidget.dismiss();
      }
      showGetXNetworkDialog(result);
    });
  }

  getUserInfo(ValueChanged<bool> valueChanged) {
    UserInfoApi().request().then((result) {
      LoadingWidget.dismiss();
      if (result.success == true) {
        GlobalVariable.userInfo = result.data;
        GlobalVariable.auth.value = true;
        valueChanged(true);
      }
      showGetXNetworkDialog(result);
    });
  }

  @override
  void onReady() {
    super.onReady();
    // getGetCaptcha();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future<bool> didPopRoute() {
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
    phoneNode.dispose();
    passwordNode.dispose();
  }
}
