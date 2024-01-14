import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '/common/global/global_constant.dart';
import '/common/widget/osstp_getx_dialog.dart';
import '/common/widget/inkWell_button.dart';
import '../../../../../common/config/application_config.dart';
import '../../../../../common/widget/divider_line_widget.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../controller/about_controller.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
      init: AboutController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(title: S.of(context).setting_about),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ApplicationConfig.logoWidget,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.application_name,
                              style: const TextStyle(
                                  color: Color(0xFF00D6F7),
                                  fontFamily: ConstantFonts.STLITI,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text("Version ${controller.version.value}"),
                            ),
                          ],
                        ),
                      ),
                      AnimationLimiter(
                          child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10, bottom: 77),
                        itemCount: controller.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: buildItem(context, controller, index),
                              ),
                            ),
                          );
                        },
                      ))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: DividerLineView(
                          indent: 15,
                          endIndent: 15,
                        ),
                      ),
                      Text(
                        "OSSTP ${S.of(context).setting_about_all_rights_reserved}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Text(
                        "Copyright © 2020-2024 OSSTP.All Rights Reserved",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.android_rounded,
                            size: 20,
                          ),
                          Icon(
                            Icons.apple_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildItem(BuildContext context, AboutController controller, int index) {
    return InkWellButton.InkWell(
      onTap: () {
        if (controller.itemList[index].routesName == "") {
          GetXDialogDebug(controller.itemList[index].title);
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Offstage(
              offstage: index != 0,
              child: DividerLineView(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.itemList[index].title ?? ''),
                        Offstage(
                          offstage: controller.itemList[index].child == null ? true : false,
                          child: controller.itemList[index].child,
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: controller.itemList[index].image == null ? true : false,
                    child: Icon(controller.itemList[index].image),
                  )
                ],
              ),
            ),
            DividerLineView()
          ],
        ),
      ),
    );
  }
}
