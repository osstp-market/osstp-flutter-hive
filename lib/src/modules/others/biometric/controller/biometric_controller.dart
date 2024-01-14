import 'package:get/get.dart';
import '/common/utils/authentication_utils.dart';

class BiometricController extends SuperController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 100)).then((onValue) {
      AuthenticationUtils.instance.initPlatformState();
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
