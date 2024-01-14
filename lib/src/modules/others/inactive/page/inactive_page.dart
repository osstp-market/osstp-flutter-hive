import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/l10n.dart';
import '/common/global/global_constant.dart';
import '/common/theme/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../common/config/application_config.dart';
import '../controller/inactive_controller.dart';

class InactivePage extends StatefulWidget {
  const InactivePage({Key? key}) : super(key: key);

  @override
  State<InactivePage> createState() => _InactivePageState();
}

class _InactivePageState extends State<InactivePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InactiveController>(
      init: InactiveController(),
      builder: (controller) {
        return Material(
          child: Scaffold(
            backgroundColor: ThemeColors.scaffoldThemeColor(context),
            body: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Stack(
                children: <Widget>[
                  const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.hive_rounded,
                        color: Colors.white,
                        size: 120,
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
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
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
}
