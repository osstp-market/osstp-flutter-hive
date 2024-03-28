import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:osstp_network/osstp_network.dart';

import '../widget/loading_widget.dart';
import '../widget/osstp_getx_dialog.dart';

Future<T?>? showGetXNetworkDialog<T>(
  ResponseResult result, {
  bool showSuccess = true,
  bool showError = true,
  TextAlign? contentTextAlign = TextAlign.center,
  String? confirmTitle,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  if (showSuccess == true && result.success == true) {
    return LoadingWidget.showSuccess(status: result.deserialize?.msg?.msg);
  } else if (showError == true && result.success == false) {
   return  GetXDialog.show(
      config: OsstpDialogConfig(
          title: result.deserialize?.msg?.title,
          content: result.deserialize?.msg?.msg,
          contentTextAlign: contentTextAlign,
          confirmTitle: confirmTitle,
          onConfirm: onConfirm,
          onCancel: onCancel),
    );
  } else {
    return null;
  }
}

Future<T?>? showGetXGeneralDialog<T>({
  String? title,
  String? content,
  Widget? contentWidget,
  TextAlign? contentTextAlign = TextAlign.center,
  bool showCancelButton = false,
  String? confirmTitle,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return GetXDialog.show(
    config: OsstpDialogConfig(
        title: title,
        content: content,
        contentWidget: contentWidget,
        contentTextAlign: contentTextAlign,
        showCancelButton: showCancelButton,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
        onCancel: onCancel),
  );
}


GetXDialogDebug(String? title) {
  showGetXGeneralDialog(
    title: title,
    contentWidget: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Custom content widget',
          textAlign: TextAlign.center,
        ),
        Text(
          'Under construction',
          textAlign: TextAlign.center,
        )
      ],
    )
  );
}