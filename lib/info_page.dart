import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {

  final String? msg;

  const InfoPage({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "INFO",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  msg ?? "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
