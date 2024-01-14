import '../routers/routers_handle.dart';
import 'package:fluro/fluro.dart';

class Routers {
  static const String splashPage = "splash_page"; // 不需要斜线（'/'）  ，防止main tab bar 页面带有返回键
  static const String guidePage = "/guide_page";
  static const String mainTabBar = "/main_tab_bar";
  static const String modulesPage = "/modules_page";
  
  static const String loginPage = "/login_page";
  static const String registerPage = "/register_page";

  static const String favorPage = "/favor_page";
  static const String homePage = "/home_page";
  static const String minePage = "/mine_page";

  static const String settingHomePage = "/setting_home_page";
  static const String localizationsPage = "/localizations_page";
  static const String themeSettingPage = "/theme_setting_page";
  static const String biometricSettingPage = "/biometric_setting_page";
  static const String biometricPage = "/biometric_page";
  static const String aboutPage = "/about_page";
  static const String webViewLoadingPage = "/web_view_loading_page";

  static const String mineProfilePage = "/mine_profile_page";
  static const String deviceInfoPage = "/device_info_page";
  static const String badgePage = "/badge_page";
  static const String videoPlayerPage = "/video_player_page";
  static const String ijkVideoPlayerPage = "/ijk_video_player_page";
}

class RoutersConfig {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = routeNotFoundHandle;

    ///
    router.define(Routers.splashPage, handler: splashPageHandler);
    router.define(Routers.guidePage,
        handler: guidePageRouteHandler,
        transitionType: TransitionType.fadeIn,
        transitionDuration: const Duration(milliseconds: 500));
    router.define(Routers.mainTabBar,
        handler: mainTabBarRouteHandler,
        transitionType: TransitionType.fadeIn,
        transitionDuration: const Duration(milliseconds: 500));
    router.define(Routers.modulesPage, handler: modulePageRouteHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.biometricSettingPage, handler: biometricSettingPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.biometricPage, handler: biometricPageHandler, transitionType: TransitionType.inFromRight);

    router.define(Routers.favorPage, handler: favorPageHandler, transitionType: TransitionType.inFromRight);

    ///
    // router.define(Routers.advertisementPage,
    //     handler: advertisementPageRouteHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.settingHomePage, handler: settingHomePageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.localizationsPage,
        handler: localizationsPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.themeSettingPage,
        handler: settingThemeSettingPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.aboutPage,
        handler: aboutPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.webViewLoadingPage,
        handler: webViewLoadingPageHandler, transitionType: TransitionType.inFromRight);

    router.define(Routers.mineProfilePage, handler: mineProfilePageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.deviceInfoPage, handler: deviceInfoPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.badgePage, handler: badgePageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.videoPlayerPage, handler: videoPlayerPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.ijkVideoPlayerPage, handler: ijkVideoPlayerPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.registerPage, handler: registerPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.loginPage, handler: loginPageHandler, transitionType: TransitionType.inFromRight);
    // router.define(Routers.editPage, handler: editPageRouteHandler, transitionType: TransitionType.inFromRight);
    // router.define(Routers.editPreviewPage, handler: editPreviewPageRouteHandler, transitionType: TransitionType.inFromRight);
    // router.define(Routers.templateEditPage, handler: templateEditPageRouteHandler, transitionType: TransitionType.inFromRight);
  }
}
