import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import 'common/config/application_config.dart';
import 'common/global/global_variable.dart';
import 'common/utils/logger.dart';
import 'main_app.dart';
import 'main.mapper.g.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    initializeJsonMapper();
    // New project should set yourself parameters by
    // ApplicationConfig instance
    await ApplicationConfig.instance.initConfig(Flavor.sit);
    OsstpDynamicThemeMode? themeMode = await OsstpDynamicTheme.getThemeMode();
    runApp(MainApp(themeMode: themeMode));

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }, (error, stack) {
    osstpLogger.d(
        "🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳[runZonedGuarded ERROR]:\n${error.toString()}\n🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳[STACK]:\n${stack.toString()}");
  });
}
