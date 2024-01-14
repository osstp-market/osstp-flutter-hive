import 'package:flutter/material.dart';

import '../global/global_variable.dart';

/// Init project
/// Extends AbstractApplicationConfig
/// See also:
///
///  * Example: [ApplicationConfig]
///
abstract class AbstractApplicationConfig {
  initConfig(
    Flavor flavor, {
    String? baseUrl,
    String bundleVersion = "v1.0.0",
    Widget logoWidget = const Icon(Icons.hive_rounded, size: 100),
    String defaultLanguage = "zh",
    List<String> supportLanguage = const ["zh", "en"],
  });

  Future<bool> resetConfig();
}
