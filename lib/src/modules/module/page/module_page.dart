import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widget/inkWell_button.dart';
import '../../../../common/utils/show_dialog.dart';
import '../../../../common/widget/loading_widget.dart';
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
            rightActionWidgets: [
              InkWellButton.InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Dialog"),
                  ),
                  onTap: () {
                    showGetXGeneralDialog(
                        title: "Dialog",
                        content: "Refresh ?",
                        showCancelButton: true,
                        onConfirm: () {
                          LoadingWidget.show(status: "Loading...");
                          Future.delayed(const Duration(seconds: 5)).then((value) {
                            LoadingWidget.showSuccess(status: "Success");
                            Future.delayed(LoadingWidget.displayDuration).then((value) {
                              LoadingWidget.showToast(status: "Toast Success");
                            });
                          });
                        });
                  })
            ],
            // onTapFunction: (OnTapModel tapModel) {
            //
            // },
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
