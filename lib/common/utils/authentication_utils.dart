import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import '../../src/routers/routers_config.dart';
import '../../src/routers/routers_navigator.dart';
import '/common/utils/shared_preferences_utils.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';

import '../../../../../common/utils/logger.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class AuthenticationUtils {
  static final AuthenticationUtils _instance = AuthenticationUtils();
  static AuthenticationUtils get instance => _instance;

  final auth = LocalAuthentication();
  final supportState = SupportState.unknown.obs;
  final canCheckBiometrics = false.obs;
  final availableBiometrics = [].obs;
  final isAuthenticating = false.obs;
  final authorized = 'Not Authorized'.obs;

  // 是否开启认证功能
  final biometricsEnable = false.obs;

  /// init
  Future<void> initPlatformState() async {
    supportState.value = SupportState.unknown;
    canCheckBiometrics.value = false;
    availableBiometrics.value = [];
    isAuthenticating.value = false;
    authorized.value = 'Not Authorized';

    // 获取认证支持状态
    auth.isDeviceSupported().then((bool isSupported) {
      supportState.value = isSupported ? SupportState.supported : SupportState.unsupported;
      //

      if (supportState.value == SupportState.supported) {
        checkBiometrics();
      }
    });
  }

  Future<void> checkBiometrics() async {
    late bool biometrics;
    try {
      biometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      biometrics = false;
      osstpLoggerNoStack.d(e);
    }
    canCheckBiometrics.value = biometrics;

    if (canCheckBiometrics.value == true) {
      getAvailableBiometrics();
    }
  }

  /// Possible values include:
  /// - BiometricType.face
  /// - BiometricType.fingerprint
  /// - BiometricType.iris (not yet implemented)
  /// - BiometricType.strong
  /// - BiometricType.weak
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometrics;
    try {
      biometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      biometrics = <BiometricType>[];
      osstpLoggerNoStack.d(e);
    }
    availableBiometrics.value = biometrics;
  }

  /// 认证
  Future<void> authenticate(BuildContext context, {ValueChanged? valueCallback}) async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          // stickyAuth: true,
          // biometricOnly: true,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ],
      );
      isAuthenticating.value = false;
      authedFinish(context, authenticated, valueCallback: valueCallback);
    } on PlatformException catch (e) {
      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';
      authedFinish(context, authenticated, valueCallback: valueCallback);
    }
    authorized.value = authenticated ? 'Authorized' : 'Not Authorized';
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          // stickyAuth: true,
          biometricOnly: true,
        ),
      );

      isAuthenticating.value = false;
      authorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    } on PlatformException catch (e) {
      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';

      return;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';

    authorized.value = message;
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating.value = false;
  }

  authedFinish(BuildContext context, bool authenticated, {ValueChanged? valueCallback}) {
    // 自定义处理事件
    if (valueCallback != null) {
      valueCallback(authenticated);
    } else {
      // 实现跳转
      if (authenticated) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          if (Navigator.of(context).canPop()) {
            Application.pop(context);
          } else {
            Application.push(context, Routers.mainTabBar, replace: true, transitionDuration: const Duration(seconds: 1))
                ?.then((value) {});
          }
        });
      }
    }

  }

  initBiometricsEnableConfig() async {
    bool? value = await OsstpLocalStorage.fromPrefs(LocalStoreKey.biometricsEnable, isBoolValue: true);
    biometricsEnable.value = value ?? false;
    return value ?? false;
  }

  setBiometricsEnableState(bool value) {
    biometricsEnable.value = value;
    OsstpLocalStorage.savePrefs(LocalStoreKey.biometricsEnable, boolValue: value);
  }
}
