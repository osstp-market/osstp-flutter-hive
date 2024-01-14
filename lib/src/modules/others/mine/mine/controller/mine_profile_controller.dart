import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '/common/utils/show_dialog.dart';
import '/src/modules/others/login/api/login_api.dart';

import '../../../../../../common/global/global_variable.dart';
import '../../../../../../common/widget/loading_widget.dart';
import '../../../../../../generated/l10n.dart';


class MineProfileController extends SuperController {
  List<UIModel> uiList = [];

  XFile? pickedImageFile;
  CroppedFile? croppedImageFile;

  @override
  void onInit() {
    super.onInit();
    buildUIData();
  }

  @override
  void onClose() {
    super.onClose();
    _clear();
  }

  Future<void> uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImageFile = pickedFile;
    }
  }

  void _clear() {
    pickedImageFile = null;
    croppedImageFile = null;
  }

  Future<void> cropImage() async {
    if (pickedImageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImageFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: S.current.mine_profile_tailor,
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: S.current.mine_profile_tailor,
          ),
        ],
      );
      if (croppedFile != null) {
        croppedImageFile = croppedFile;
        update();
      }
    }
  }

  buildUIData() {
    uiList.clear();

    uiList.add(UIModel(title: S.current.mine_profile_name, content: "${GlobalVariable.userInfo?.nickname}"));
    uiList.add(UIModel(title: S.current.mine_profile_id, content: "${GlobalVariable.userInfo?.id}"));
    uiList.add(UIModel(title: S.current.mine_profile_phone, content: "${GlobalVariable.userInfo?.mobile}"));
    uiList.add(UIModel(title: S.current.mine_profile_qr_code, content: "QR Code"));

    update();
  }

  logoutAction(ValueChanged valueChanged) {
    LoadingWidget.show();
    LogoutApi().request().then((result) {
      LoadingWidget.dismiss();
      // success: code == 1
      if (result.success) {
        LoadingWidget.showSuccess(status: result.deserialize?.msg?.msg);
        GlobalVariable.auth.value = false;
        GlobalVariable.userInfo = null;
        valueChanged(true);
      }
      showGetXNetworkDialog(result);
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

class UIModel {
  String? title;
  String? content;
  String? router;
  UIModel({this.title, this.content, this.router});
}
