import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:osstp_dialog/osstp_dialog.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import 'src/routers/routers_config.dart';
import 'src/routers/routers_navigator.dart';
import 'src/routers/routers_observer.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'common/config/application_config.dart';
import 'common/global/global_constant.dart';
import 'generated/l10n.dart';

class MainApp extends StatefulWidget {
  final OsstpDynamicThemeMode? themeMode;
  const MainApp({Key? key, this.themeMode}) : super(key: key);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    /// Notification listening start
    // NotificationsController.initializeNotificationsEventListeners();

    /// init router
    final router = FluroRouter();
    RoutersConfig.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      //显示状态栏、底部按钮栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    } else if (orientation == Orientation.landscape) {
      //隐藏状态栏，底部按钮栏
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      //隐藏状态栏，保留底部按钮栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    }
    return OsstpDynamicThemeWidget(
      initialThemeMode: widget.themeMode ?? OsstpDynamicThemeMode.system,
      light: OsstpThemeData.lightThemeData,
      dark: OsstpThemeData.darkThemeData,
      custom: OsstpThemeData.customThemeData,
      builder: (lightTheme, darkTheme, systemThemeModel) => RefreshConfiguration(
        headerBuilder: () =>
            const WaterDropHeader(), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
        footerBuilder: () => const ClassicFooter(), // Configure default bottom indicator
        headerTriggerDistance: 80.0, // header trigger refresh trigger distance
        springDescription: const SpringDescription(
            stiffness: 170, damping: 16, mass: 1.9), // custom spring back animate,the props meaning see the flutter api
        maxOverScrollExtent:
            100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted:
            true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        enableLoadingWhenFailed:
            true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
        hideFooterWhenNotFull:
            false, // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true,
        child: GetMaterialApp(
          navigatorKey: globalNavigatorKey,
          defaultGlobalState: true,
          enableLog: false,
          logWriterCallback: _localLogWriter,
          title: "HIVE",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: systemThemeModel,
          onGenerateRoute: Application.router?.generator,
          initialRoute: Routers.splashPage,
          navigatorObservers: [GlobalRouteObserver()],
          // locale: kDebugMode ? Get.deviceLocale : null,
          supportedLocales: S.delegate.supportedLocales,
          // onGenerateInitialRoutes: onGenerateInitialRoutes,
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
            OsstpDialogLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            var result = supportedLocales.where((element) {
              return element.languageCode == locale?.languageCode;
            }).toList();
            if (result.isNotEmpty) {
              return locale;
            }
            return Locale(ApplicationConfig.defaultLanguage);
          },
          localeListResolutionCallback: (locales, Iterable<Locale> supportedLocales) {
            // osstpLoggerNoStack.d('locales:$locales');
            // return Locale(ApplicationConfig.defaultLanguage);
          },
          builder: EasyLoading.init(),
        ),
      ),
    );
  }

  // List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
  //   List<Route<dynamic>> pageStack = [];
  //   pageStack.add(MaterialPageRoute(builder: (_) => const FavorPage()));
  //   if (initialRouteName == Routers.notification && NotificationController.initialAction != null) {
  //     pageStack.add(
  //         MaterialPageRoute(builder: (_) => NotificationPage(receivedAction: NotificationController.initialAction!)));
  //   }
  //   return pageStack;
  // }

  void _localLogWriter(String text, {bool isError = false}) {
    // pass the message to your favourite logging package here
    // please note that even if enableLog: false log messages will be pushed in this callback
    // you get check the flag if you want through GetConfig.isLogEnable
    // if (kDebugMode) {
    //   print("localLogWriter: $text");
    // }
  }
}
