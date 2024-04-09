import '../routers/routers_handle.dart';
import 'package:fluro/fluro.dart';

class Routers {
  static const String splashPage = "splash_page"; // 不需要斜线（'/'）  ，防止main tab bar 页面带有返回键
  static const String guidePage = "/guide_page";
  static const String infoPage = "/info_page";
  static const String mainTabBar = "/main_tab_bar";

  static const String loginPage = "/login_page";
  static const String registerPage = "/register_page";

  static const String minePage = "/mine_page";

  static const String settingHomePage = "/setting_home_page";
  static const String localizationsPage = "/localizations_page";
  static const String themeSettingPage = "/theme_setting_page";
  static const String colorPickerPagePage = "/color_picker_page";
  static const String aboutPage = "/about_page";

  static const String mineProfilePage = "/mine_profile_page";
  static const String badgePage = "/badge_page";
}

class RouterModel {
  String router;
  String routerName;
  RouterModel({required this.router, required this.routerName});
}

List<RouterModel> routerList = [

  // General module
  RouterModel(router: Routers.splashPage, routerName: "启动画面"),
  RouterModel(router: Routers.guidePage, routerName: "引导画面"),
  RouterModel(router: Routers.mainTabBar, routerName: "main tab bar主控制器"),
  RouterModel(router: Routers.settingHomePage, routerName: "设置主画面"),
  RouterModel(router: Routers.loginPage, routerName: "登录画面"),
  RouterModel(router: Routers.registerPage, routerName: "注册画面"),
  RouterModel(router: Routers.aboutPage, routerName: "关于画面"),
];

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

    router.define(Routers.settingHomePage, handler: settingHomePageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.localizationsPage,
        handler: localizationsPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.themeSettingPage,
        handler: settingThemeSettingPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.colorPickerPagePage,
        handler: colorPickerPagePageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.aboutPage, handler: aboutPageHandler, transitionType: TransitionType.inFromRight);

    router.define(Routers.mineProfilePage, handler: mineProfilePageHandler, transitionType: TransitionType.inFromRight);

    router.define(Routers.registerPage, handler: registerPageHandler, transitionType: TransitionType.inFromRight);
    router.define(Routers.loginPage, handler: loginPageHandler, transitionType: TransitionType.inFromRight);

  }
}
