import 'dart:ui';
import 'package:osstp_network/osstp_network.dart';

import '../widget/loading_widget.dart';
import '../widget/osstp_getx_dialog.dart';

showGetXNetworkDialog(
  ResponseResult result, {
  bool showSuccess = true,
  bool showError = true,
  TextAlign? contentTextAlign = TextAlign.center,
  String? confirmTitle,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  if (showSuccess == true && result.success == true) {
    LoadingWidget.showSuccess(status: result.deserialize?.msg?.msg);
  } else if (showError == true && result.success == false) {
    GetXDialog.show(
      config: OsstpDialogConfig(
          title: result.deserialize?.msg?.title,
          content: result.deserialize?.msg?.msg,
          contentTextAlign: contentTextAlign,
          confirmTitle: confirmTitle,
          onConfirm: onConfirm,
          onCancel: onCancel),
    );
  }
}

showGetXGeneralDialog({
  String? title,
  String? content,
  TextAlign? contentTextAlign = TextAlign.center,
  bool showCancelButton = false,
  String? confirmTitle,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  GetXDialog.show(
    config: OsstpDialogConfig(
        title: title,
        content: content,
        contentTextAlign: contentTextAlign,
        showCancelButton: showCancelButton,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
        onCancel: onCancel),
  );
}
