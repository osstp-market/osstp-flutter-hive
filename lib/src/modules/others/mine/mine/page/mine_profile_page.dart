import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../../../../common/utils/show_dialog.dart';
import '../../../../../../common/utils/string_utils.dart';
import '../../../../../../common/widget/divider_line_widget.dart';
import '../../../../../../common/widget/elevated_button_widget.dart';
import '../../../../../../common/widget/inkWell_button.dart';
import '../../../../../../common/widget/main_app_bar.dart';
import '../../../../../../common/widget/osstp_getx_dialog.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../routers/routers_navigator.dart';

import '../controller/mine_profile_controller.dart';

class MineProfilePage extends StatelessWidget {
  const MineProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineProfileController>(
      init: MineProfileController(),
      initState: (state) {},
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(title: S.of(context).mine_profile_edit),
          body: SafeArea(
            child: ListView(
              children: [
                InkWellButton.normal(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: itIsEmpty(controller.croppedImageFile?.path)
                              ? const Icon(Icons.photo_library)
                              : Image.file(
                                  File(controller.croppedImageFile?.path ?? ''),
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(Icons.photo_library),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text(
                                          S.current.mine_profile_image_error,
                                          style: const TextStyle(color: Colors.white70),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // try {
                    //   final XFile? pickedFile = await controller.picker.pickImage(
                    //     source: ImageSource.gallery,
                    //   );
                    //   controller.setImageFileListFromFile(pickedFile);
                    // } catch (e) {
                    //   controller.setPickImageError(e);
                    // }

                    controller.uploadImage().then((_) {
                      controller.cropImage();
                    });
                  },
                ),
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10, bottom: 77),
                    itemCount: controller.uiList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: buildItem(
                              context,
                              controller,
                              index,
                              voidCallback: () {
                                String? router = controller.uiList[index].router;
                                if (itIsNotEmpty(router)) {
                                  Application.push(context, router!);
                                } else {
                                  GetXDialogDebug(controller.uiList[index].title);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButtonWidget.normal(
                          titleText: Text(S.of(context).general_logout),
                          onPressed: () {
                            OsstpDialog.show(
                              context: context,
                              config: OsstpDialogConfig(
                                contentTextAlign: TextAlign.center,
                                content: '${S.of(context).general_logout}?',
                                showCancelButton: true,
                                onConfirm: () {
                                  controller.logoutAction((value) {
                                    if (value == true) {
                                      Application.pop(context);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
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

  buildItem(BuildContext context, MineProfileController controller, int index, {required VoidCallback? voidCallback}) {
    return InkWellButton.InkWell(
      onTap: () {
        voidCallback!();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text(stringValue(controller.uiList[index].title)),
                  ),
                  Expanded(
                    child: Text(
                      stringValue(controller.uiList[index].content),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
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
