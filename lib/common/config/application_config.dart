import 'package:flutter/material.dart';
import '../database/database.dart';
import 'abstract_application_config.dart';
import '../../common/utils/localizations_utils.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';
import '../global/global_variable.dart';
import '../utils/shared_preferences_utils.dart';
import 'config_manager.dart';

class ApplicationConfig extends AbstractApplicationConfig {
  static final ApplicationConfig _instance = ApplicationConfig();
  static ApplicationConfig get instance => _instance;

  /// App init default config
  static String bundleVersion = "";
  static Widget logoWidget = const SizedBox();
  static String defaultLanguage = "";
  static List<String> supportLanguage = [];
  static String copyright = "";

  /// init config
  @override
  initConfig(
    Flavor flavor, {
    String? baseUrl,
    String bundleVersion = "v1.0.0",
    Widget logoWidget = const Icon(Icons.hive_rounded, size: 100),
    String defaultLanguage = "zh",
    List<String> supportLanguage = const ["zh", "en"],
    String copyright = "Copyright © 2020-2024 OSSTP.All Rights Reserved",
    bool standardService = true,
    bool shouldDataMock = false,
  }) async {
    ApplicationConfig.bundleVersion = bundleVersion;
    ApplicationConfig.logoWidget = logoWidget;
    ApplicationConfig.defaultLanguage = defaultLanguage;
    ApplicationConfig.supportLanguage = supportLanguage;
    ApplicationConfig.copyright = copyright;

    await OsstpLocalStorage.initConfig();
    await LocalizationsUtils.current.initConfig();

    // init database path
    await dbPathConfig();

    await ConfigManager.initConfig(flavor, baseUrl, standardService: standardService, shouldDataMock: shouldDataMock);
  }

  /// reset config
  @override
  Future<bool> resetConfig() async {
    bool result1 = await SharedPreferencesUtils.resetPreferencesData();

    return result1;
  }
}
