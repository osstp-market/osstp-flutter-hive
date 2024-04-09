import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';

import '../guide/page/guide_page.dart';
import '../login/page/login_page.dart';
import '../main_tabbar/page/main_tabbar_page.dart';
import '../mine/about/page/about_page.dart';
import '../mine/localizations/page/localizations_page.dart';
import '../mine/mine/page/mine_profile_page.dart';
import '../mine/setting/page/setting_home_page.dart';
import '../mine/theme/page/theme_picker_page.dart';
import '../mine/theme/page/theme_setting_page.dart';
import '../register/page/register_page.dart';
import '../splash/page/splash_page.dart';


var routeNotFoundHandle = Handler(
  type: HandlerType.function,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    if (kDebugMode) {
      print("ROUTE WAS NOT FOUND !!!");
    }
    showDialog(
      context: context!,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Hey Hey!",
            style: TextStyle(
              color: Color(0xFF00D6F7),
              fontFamily: "Lazer84",
              fontSize: 22.0,
            ),
          ),
          content: const Text("ROUTE WAS NOT FOUND !!!"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("OK"),
              ),
            ),
          ],
        );
      },
    );
    return;
  },
);

var splashPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SplashPage();
});

var guidePageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const GuidePage();
});
var mainTabBarRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const MainTabBarPage();
});

var registerPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const RegisterPage();
});
var loginPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});
var settingHomePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SettingHomePage();
});



var aboutPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const AboutPage();
});

var localizationsPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LocalizationsPage();
});
var settingThemeSettingPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
// return DemoSimpleComponent(message: message, color: color, result: result);
  return const ThemeSettingPage();
});
var colorPickerPagePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  ThemeColorModel? arguments = context?.settings?.arguments as ThemeColorModel?;
  return ColorPickerPage(
    themeColorModel: arguments,
  );
});
var mineProfilePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
// return DemoSimpleComponent(message: message, color: color, result: result);
  return const MineProfilePage();
});
