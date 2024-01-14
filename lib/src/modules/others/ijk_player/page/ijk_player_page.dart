import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/IJKPlayerController.dart';


class IJKPlayerPage extends StatefulWidget {
  const IJKPlayerPage({Key? key}) : super(key: key);

  @override
  State<IJKPlayerPage> createState() => _IJKPlayerPageState();
}

class _IJKPlayerPageState extends State<IJKPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IJKPlayerController>(
      init: IJKPlayerController(),
      builder: (IJKPlayerController controller) {
        return Container();
      },
    );
  }
}
