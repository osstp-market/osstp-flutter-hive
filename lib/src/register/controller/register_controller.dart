import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/register_api.dart';
import '/common/global/global_variable.dart';
import '/common/utils/show_dialog.dart';

import '../../../../../common/utils/crypto_utils.dart';

class RegisterController extends SuperController {
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();

  final agreeFlag = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
  register() async {
    String crypto = await cryptoByPem("123456");

    RegisterApi(mobile: "18659187687", userName: "admin77", password: crypto).request().then((result) {

      if(result.success) {
        // save register info
        GlobalVariable.userInfo = result.data;
        print(GlobalVariable.userInfo?.mobile);
        print(GlobalVariable.userInfo?.username);
      }
      showGetXNetworkDialog(result);
    });
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
}
