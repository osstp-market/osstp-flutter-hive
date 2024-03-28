import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import '../../../../../src/modules/others/theme/page/theme_picker_page.dart';
import '../others/clock/page/clock_page.dart';
import '../others/notification/page/media_details_page.dart';
import '../others/notification/page/notification_details_page.dart';
import '../others/notification/page/phone_call_page.dart';

import '../others/notification/controller/notification_controller.dart';
import '../others/notification/page/notification_setting_page.dart';
import '../others/refresh/page/refresh_page.dart';
import '../../main_tabbar/page/main_tabbar_page.dart';
import '../module/page/module_page.dart';
import '../others/about/page/about_page.dart';
import '../others/badge/page/badge_page.dart';
import '../others/biometric/page/biometric_page.dart';
import '../others/biometric/page/biometric_setting_page.dart';
import '../others/device_info/page/device_info_page.dart';
import '../others/favor/favor/page/favor_page.dart';
import '../others/localizations/page/localizations_page.dart';
import '../others/mine/mine/page/mine_profile_page.dart';
import '../others/setting/page/setting_home_page.dart';
import '../others/theme/page/theme_setting_page.dart';
import '../others/guide/page/guide_page.dart';
import '../others/login/page/login_page.dart';
import '../others/register/page/register_page.dart';
import '../others/splash/page/splash_page.dart';
import '../others/webview/page/webview_loading_widget_page.dart';

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
var modulePageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ModulePage();
});
var notificationSettingPageRouteHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const NotificationSettingPage();
});

var notificationDetailPageRouteHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  ReceivedNotification receivedNotification = ModalRoute.of(context!)!.settings.arguments as ReceivedNotification;
  return NotificationDetailsPage(receivedNotification);
});

var mediaDetailsPageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const MediaDetailsPage();
});
var phoneCallPageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  ReceivedAction? receivedAction = ModalRoute.of(context!)!.settings.arguments == null
      ? NotificationsController.initialCallAction
      : ModalRoute.of(context)!.settings.arguments as ReceivedAction;
  return PhoneCallPage(
    receivedAction: receivedAction!,
  );
});
var registerPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const RegisterPage();
});
var loginPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});
var clockPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ClockPage();
});

// var editPreviewPageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return EditPreviewPage();
// });
// var templateEditPageRouteHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//   HomeEditItemListModel? listModel = JsonMapper.fromJson<HomeEditItemListModel>(convert.jsonDecode(params['model'].first));
//   print(listModel?.editItemList.length);
//   return EditTemplatePage(itemListModel: listModel);
// });
//
// var cyclePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return const CyclePage();
// });

var settingHomePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SettingHomePage();
});

var biometricSettingPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const BiometricSettingPage();
});
var biometricPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const BiometricPage();
});
var favorPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const FavorPage();
});
var aboutPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const AboutPage();
});
var webViewLoadingPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  WebViewLoadingModel? arguments = context?.settings?.arguments as WebViewLoadingModel?;
  return WebViewLoadingWidgetPage(
    title: arguments?.title,
    url: arguments?.url,
  );
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
var refreshPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
// return DemoSimpleComponent(message: message, color: color, result: result);
  return const RefreshPage();
});
var deviceInfoPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const DeviceInfoPage();
});
var badgePageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const BadgePage();
});
var videoPlayerPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return VideoPlayerPage();
});
var ijkVideoPlayerPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return VideoPlayerPage();
});

//
// /// Handles deep links into the app
// /// To test on Android:
// ///
// /// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.theyakka.fluro`
// var loginPageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
//   // UserInfoModel? userInfoModel = UserInfoModel.fromJson(convert.jsonDecode(params['userInfoModel'][0]));
//   return LoginPage(
//       // userInfoModel: userInfoModel,
//       );
// });
//
