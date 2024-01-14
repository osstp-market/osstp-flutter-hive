import 'dart:async';
import 'package:flutter/material.dart';
import 'main.mapper.g.dart';
import 'main_app.dart';

/// Run the code generation step with the root of your package as the current directory:
/// $: dart run build_runner build --delete-conflicting-outputs
/// You'll need to re-run code generation each time you are making changes to lib/main.dart So for development time, use watch like this
/// $: dart run build_runner watch --delete-conflicting-outputs
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    initializeJsonMapper();
    runApp(const MainApp());
  }, (error, stack) {});
}
