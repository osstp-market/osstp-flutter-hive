import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/global_variable.dart';

class DebugDisplayTagWidget extends StatelessWidget {
  DebugDisplayTagWidget({Key? key, this.child, this.fontSize}) : super(key: key);

  /// NOTE:
  /// child：release display
  Widget? child;

  double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GlobalVariable.isDebug
            ? Container(
                color: Colors.redAccent.withOpacity(0.2),
                child:
                    Text("DEBUG", style: TextStyle(fontSize: (fontSize ?? 15), color: Colors.orange.withOpacity(0.5))))
            : const SizedBox(),
        GlobalVariable.isDebug ? (child ?? const SizedBox()) : const SizedBox(),
        GlobalVariable.isDebug
            ? Text("DEBUG", style: TextStyle(fontSize: (fontSize ?? 15), color: Colors.orange.withOpacity(0.5)))
            : const SizedBox(),
      ],
    );
  }
}
