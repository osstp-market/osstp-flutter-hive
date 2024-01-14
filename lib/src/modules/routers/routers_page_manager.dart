import '../../../common/utils/logger.dart';
import '../../../common/utils/string_utils.dart';
import 'routers_config.dart';

const String didPushEvent = 'didPush';
const String didPopEvent = 'didPop';
const String didReplaceEvent = 'didReplace';
const String didRemoveEvent = 'didRemove';
const String didStartUserGestureEvent = 'didStartUserGesture';

/// custom event
const String initiativeEvent = 'initiative';

class PageEventManager {
  static String _routerPage = '';
  static String _tabBarIndexPage = '';

  static String routerToggleEvent(String? event, String? router, {String? routerPage, bool logger = true}) {
    if (routerPage != null) {
      _routerPage = routerPage;
      _tabBarIndexPage = routerPage;
    } else {
      //
      _routerPage = '';
    }
    if (router == Routers.mainTabBar) {
      _routerPage = _tabBarIndexPage;
    }

    String routerName = '';
    switch (router) {
      case Routers.splashPage:
        routerName = '启动画面';
        break;
      case Routers.guidePage:
        routerName = '引导画面';
        break;
      case Routers.mainTabBar:
        routerName = 'main tab bar主控制器';
        break;
      case Routers.loginPage:
        routerName = '登录画面';
        break;
      case Routers.registerPage:
        routerName = '注册画面';
        break;
      case Routers.homePage:
        routerName = 'home画面';
        break;
      case Routers.favorPage:
        routerName = '偏好画面';
        break;
      case Routers.minePage:
        routerName = '我的画面';
        break;
      case Routers.settingHomePage:
        routerName = '设置主画面';
        break;
      case Routers.localizationsPage:
        routerName = '切换语言画面';
        break;
      case Routers.modulesPage:
        routerName = '组件画面';
        break;
      case Routers.themeSettingPage:
        routerName = '切换主题画面';
        break;
      case Routers.biometricPage:
        routerName = '生物认证画面';
        break;
      case Routers.biometricSettingPage:
        routerName = '生物认证设置画面';
        break;
      case Routers.aboutPage:
        routerName = '关于画面';
        break;
      case Routers.mineProfilePage:
        routerName = '编辑资料画面';
        break;
      case Routers.deviceInfoPage:
        routerName = '设备信息画面';
        break;
      case Routers.badgePage:
        routerName = 'badge画面';
        break;
      case Routers.videoPlayerPage:
        routerName = 'VideoPlayer 画面';
        break;
      case Routers.ijkVideoPlayerPage:
        routerName = 'ijk VideoPlayer 画面';
        break;
      default:
        routerName = '';
    }
    if (logger == true) {
      osstpLogger.d(
          "$event current route: $router\n$event route name: $routerName${itIsEmpty(_routerPage) ? '' : '\npage router: $_routerPage\npage name: ${routerToggleEvent(event, _routerPage, logger: false)}'}");
    }
    return routerName;
  }
}
