import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:osstp_network/osstp_network.dart';

import '../utils/authentication_utils.dart';
import '../utils/badge_utils.dart';
import '/common/global/global_variable.dart';
import '../widget/loading_widget.dart';
import '../widget/osstp_getx_dialog.dart';
import '../../src/modules/others/notification/controller/notification_controller.dart';

class ConfigManager {
  /*
  * App init config argument
  *
  * flavor: dev sit uat prod
  * standardService: standard service data
  * shouldDataMock: use mock data for test
  * */
  static initConfig(Flavor? flavor, String? baseUrl,
      {bool standardService = true, bool shouldDataMock = false}) async {
    GlobalVariable.flavor = flavor;
    switch (flavor) {
      case Flavor.dev:
        GlobalVariable.baseUrl = baseUrl ?? "";
        break;
      case Flavor.sit:
        GlobalVariable.baseUrl = baseUrl ?? "";
        break;
      case Flavor.uat:
        GlobalVariable.baseUrl = baseUrl ?? "";
        break;
      case Flavor.prod:
        GlobalVariable.baseUrl = baseUrl ?? "";
        break;
    }

    // Base config
    // Always initialize Awesome Notifications
    await NotificationsController.initializeLocalNotifications();
    await NotificationsController.initializeIsolateReceivePort();
    BadgeUtils.badgeConfig();
    await AuthenticationUtils.instance.initBiometricsEnableConfig();

    // plugins config init
    _dialogDefaultConfig();
    _easyLoadingConfig();
    _networkConfig(standardService: standardService,shouldDataMock: shouldDataMock);
  }

  /// Init set up Dialog default language
  /// default is English if not set up
  static _dialogDefaultConfig() {
    OsstpDialogDefault.instance
      ..cancelTitle
      ..confirmTitle
      ..portraitMaxWidthOffset
      ..landscapeMaxWidthOffset;
  }

  /// EasyLoading
  static _easyLoadingConfig() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  /// set up network
  static _networkConfig({bool standardService = true, bool shouldDataMock = false}) {
    OsstpNetworkConfig.instance.config(
      // connectTimeout: ,
      defaultOptions: OsstpOptions(
        baseUrl: GlobalVariable.baseUrl,
        standardService: standardService,
        shouldDataMock: shouldDataMock, // mock test model
      ),
      loggerLevel: OsstpNetworkLogLevel.headerBody,
    );
  }
}
