import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:osstp_dialog/osstp_dialog.dart';
import '/common/widget/elevated_button_widget.dart';
import 'generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialErrorPage extends StatelessWidget {
  final String? errorMsg;

  const InitialErrorPage({Key? key, this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "HIVE",
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
        OsstpDialogLocalizations.delegate,
      ],
      home: CustomErrorPage(msg: errorMsg),
    );
  }
}

class CustomErrorPage extends StatelessWidget {
  final String? msg;

  const CustomErrorPage({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "CRASH INFO",
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButtonWidget.normal(
              backgroundColor: Colors.red,
              titleText: const Text('FEEDBACK'),
              onPressed: () {
                String encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: '861528778@qq.com',
                  query: encodeQueryParameters(<String, String>{'subject': '[HIVE]CRASH INFO', 'body': msg ?? ''}),
                );

                OsstpDialog.show(
                  context: context,
                  config: OsstpDialogConfig(
                    title: 'CRASH INFO',
                    content: 'Upload ?',
                    contentTextAlign: TextAlign.center,
                    showCancelButton: true,
                    onConfirm: () {
                      launchUrl(emailLaunchUri).then((bool value) {});
                    },
                  ),
                );
              },
            ),
          )
        ],
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
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
