import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../../../common/widget/main_app_bar.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../routers/routers_config.dart';
import '../../../../routers/routers_navigator.dart';
import '/common/widget/elevated_button_widget.dart';
import '../controller/favor_controller.dart';

class FavorPage extends StatefulWidget {
  const FavorPage({Key? key}) : super(key: key);

  @override
  State<FavorPage> createState() => _FavorPageState();
}

class _FavorPageState extends State<FavorPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavorController>(
      init: FavorController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
            title: S.of(context).tabbar_favor,
          ),
          body: Column(
            children: [
              Container(
                child: ElevatedButtonWidget.normal(
                  titleText: Text("video"),
                  onPressed: () {
                    Application.push(context, Routers.videoPlayerPage);
                  },
                ),
              ),
              ElevatedButtonWidget.normal(titleText: Text("-=-=-==-="), onPressed: () {



              },)
            ],
          ),
        );
      },
    );
  }
}
