import 'package:flutter/material.dart';
import 'abstract_application_config.dart';
import '../../common/utils/localizations_utils.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';
import '../global/global_variable.dart';
import '../utils/shared_preferences_utils.dart';
import 'config_manager.dart';

class ApplicationConfig extends AbstractApplicationConfig {
  static final ApplicationConfig _instance = ApplicationConfig();
  static ApplicationConfig get instance => _instance;

  /// App Name
  static String bundleVersion = "1.0.0";
  static Widget logoWidget = const Icon(Icons.hive_rounded, size: 100);
  static String defaultLanguage = "zh";
  static List<String> supportLanguage = ["zh", "en"];

  /// init config
  @override
  initConfig(
    Flavor flavor, {
    String? baseUrl,
    String bundleVersion = "v1.0.0",
    Widget logoWidget = const Icon(Icons.hive_rounded, size: 100),
    String defaultLanguage = "zh",
    List<String> supportLanguage = const ["zh", "en"],
  }) async {
    ApplicationConfig.bundleVersion = bundleVersion;
    ApplicationConfig.logoWidget = logoWidget;
    ApplicationConfig.defaultLanguage = defaultLanguage;
    ApplicationConfig.supportLanguage = supportLanguage;

    await OsstpLocalStorage.initConfig();
    await LocalizationsUtils.current.initConfig();

    ///
    ConfigManager.initConfig(flavor, baseUrl);
  }

  /// reset config
  @override
  Future<bool> resetConfig() async {
    bool result1 = await SharedPreferencesUtils.resetPreferencesData();

    return result1;
  }
}
