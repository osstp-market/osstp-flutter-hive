import 'dart:async';
import 'package:flutter/material.dart';
import 'main.mapper.g.dart';
import 'main_app.dart';

/// Run the code generation step with the root of your package as the current directory:
/// $: dart run build_runner build --delete-conflicting-outputs
/// You'll need to re-run code generation each time you are making changes to lib/main.dart So for development time, use watch like this
/// $: dart run build_runner watch --delete-conflicting-outputs
void main() {
  /***
   * Dart 2.12 开始，runZonedGuarded 替代了 runZoned
   * 参考：https://medium.com/dartlang/dart-2-12-now-available-4b3
   * 注意：
   *      Android Studio 运行时如果运行到此方法 需要在[Configuration]配置flavor 参数 dev/sit/uat/prod
   *      flutter build apk --flavor dev
   *      flutter build apk --flavor sit
   *      flutter build apk --flavor uat
   *      flutter build apk --flavor prod
   *      flutter build apk --flavor dev --release
   *      flutter build apk --flavor sit --release
   *      flutter build apk --flavor uat --release
   *      flutter build apk --flavor prod --release
   */
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    initializeJsonMapper();
    runApp(const MainApp());
  }, (error, stack) {});
}
