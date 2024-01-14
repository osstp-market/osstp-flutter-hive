import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/widget/main_app_bar.dart';
import '/src/modules/module/view/module_list_item.dart';
import '../../../../generated/l10n.dart';
import '../../routers/routers_navigator.dart';
import '../controller/module_controller.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModuleController>(
      init: ModuleController(),
      initState: (getState) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
            title: '${S.current.tabbar_module}(${controller.itemList.length})',
            rightActions: [" + "],
            onTapFunction: (OnTapModel tapModel) {
              print(tapModel.index);
              print(tapModel.name);
            },
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: controller.itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return ModuleListItem(
                  selected: true,
                  title: controller.itemList[index].title!,
                  image: controller.itemList[index].image!,
                  voidCallback: () {
                    Application.push(
                      context,
                      controller.itemList[index].routesName!,
                      transition: TransitionType.fadeIn,
                      routeSettings: controller.itemList[index].routeSettings ??
                          RouteSettings(
                            arguments: NavigatePushArguments(isPreview: true), // 参数识别关闭方式
                          ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
