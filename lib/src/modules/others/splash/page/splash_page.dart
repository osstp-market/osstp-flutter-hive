import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/utils/string_utils.dart';
import '../../../../../common/widget/debug_tag_widget.dart';
import '../../../../../common/global/global_variable.dart';
import '../../../../../generated/l10n.dart';
import '/common/global/global_constant.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../common/utils/shared_preferences_utils.dart';
import '../../../routers/routers_config.dart';
import '../../../routers/routers_navigator.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Material(
          child: Scaffold(
            backgroundColor: GlobalVariable.isDebug ? null : const Color(0xffF67900),
            body: PopScope(
              canPop: false,
              child: Stack(
                children: <Widget>[
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.hive_rounded,
                        color: Colors.white,
                        size: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 117.0),
                        child: _linerIndicator(voidCallback: () {
                          _newPage(context);
                        }),
                      ),
                    ],
                  )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.current.application_name,
                            style: const TextStyle(
                              color: Color(0xFF00D6F7),
                              fontFamily: ConstantFonts.STLITI,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        DebugDisplayTagWidget(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.android_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              Icon(
                                Icons.apple_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _linerIndicator({VoidCallback? voidCallback}) {
    return LinearPercentIndicator(
      width: 160,
      animation: true,
      lineHeight: 10.0,
      animationDuration: 1500,
      percent: 1.0,
      barRadius: const Radius.circular(5),
      progressColor: Colors.cyan,
      alignment: MainAxisAlignment.center,
      onAnimationEnd: () {
        if (voidCallback != null) {
          voidCallback();
        }
      },
    );
  }

  _newPage(BuildContext context) {
    String routing = "";
    bool? hasDisplay = OsstpLocalStorage.fromPrefs(LocalStoreKey.guideHasDisplay, isBoolValue: true);
    if (hasDisplay == true) {
      if (GlobalVariable.isProd == true && itIsNotEmpty(GlobalConstant.router)) {
        // 打相应的渠道包
        routing = GlobalConstant.router;
      } else {
        routing = Routers.mainTabBar;
      }
    } else {
      routing = Routers.guidePage;
    }
    //
    NavigatePushArguments? arguments = context.settings?.arguments as NavigatePushArguments?;
    if (arguments?.isPreview == true) {
      // module 预览
      Application.pop(context);
    } else {
      Application.push(context, routing, replace: true);
    }
  }

  // _newPage() {
  //   bool? hasDisplay = OsstpLocalStorage.fromPrefs(LocalStoreKey.guideHasDisplay, isBoolValue: true);
  //   if (hasDisplay == true) {
  //     // Get.to(() => const MainTabBarPage());
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) {
  //       return const MainTabBarPage();
  //     }), (route) => route == null);
  //   } else {
  //     // Get.to(() => const GuidePage());
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) {
  //       return const GuidePage();
  //     }), (route) => route == null);
  //   }
  // }
}
