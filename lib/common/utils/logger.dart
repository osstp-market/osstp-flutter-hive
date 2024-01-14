import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// plugin: logger: ^1.1.0
///
/// custom interface
///
/// ```Dart Example:
///
/// osstpLogger.d("message");
/// or
/// osstpLogger.d(
///               {
///               "key1":"value1",
///                "key2":"value2"
///               }
///             );
/// ```
var osstpLogger = Logger(
  filter: CustomFilter(),
  printer: PrettyPrinter(
      methodCount: 4, // number of method calls to be displayed
      printTime: true,
      printEmojis: true),
  output: ConsoleOutput(),
);
var osstpLoggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0, printTime: true, printEmojis: true),
);

/// To show only specific log levels, you can set:
void setOnlyVerboseLeve() {
  // logger.v("Verbose log");
  Logger.level = Level.verbose;
}

void setOnlyDebugLeve() {
  // logger.d("Debug log");
  Logger.level = Level.debug;
}

void setOnlyInfoLeve() {
  Logger.level = Level.info;
}

void setOnlyWarningLeve() {
  // logger.w("Warning log");
  Logger.level = Level.warning;
}

void setOnlyErrorLeve() {
  // logger.e("Error log");
  Logger.level = Level.error;
}

void setOnlyTerribleLeve() {
  // logger.wtf("What a terrible failure log");
  Logger.level = Level.warning;
}

/// custom LogFilter
class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kDebugMode) {
      return true;
    } else {
      // release
      if (event.level == Level.error) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
// osstpPrint(Object? object) {
//   if (kDebugMode)
//     print("⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐️OSSTP DEBUG LOGGER⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐️\n"
//         "🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬"
//         "️\n $object\n"
//         "🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳"
//         "\n\n");
// }
