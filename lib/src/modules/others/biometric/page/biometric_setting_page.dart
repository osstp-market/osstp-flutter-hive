import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../../common/utils/authentication_utils.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../controller/biometric_controller.dart';

/// auth
class BiometricSettingPage extends StatelessWidget {
  const BiometricSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiometricController>(
      init: BiometricController(),
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(title: S.current.local_auth),
          body: Obx(() => ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  const Text("是否支持生物识别功能："),
                  if (AuthenticationUtils.instance.supportState.value == SupportState.unknown)
                    const CircularProgressIndicator()
                  else if (AuthenticationUtils.instance.supportState.value == SupportState.supported)
                    const Text('This device is supported')
                  else
                    const Text('This device is not supported'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("是否开启生物识别功能："),
                      Switch(
                        activeColor: Colors.green,
                        value: AuthenticationUtils.instance.biometricsEnable.value,
                        onChanged: (value) {
                          AuthenticationUtils.instance.setBiometricsEnableState(value);
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text('Can check biometrics: ${AuthenticationUtils.instance.canCheckBiometrics.value}\n'),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AuthenticationUtils.instance.checkBiometrics();
                        },
                        child: const Text('Check biometrics'),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text('Available biometrics:\n ${AuthenticationUtils.instance.availableBiometrics.value}\n'),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AuthenticationUtils.instance.getAvailableBiometrics();
                        },
                        child: const Text('Get available biometrics'),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text('Current State: ${AuthenticationUtils.instance.authorized.value}\n'),
                  if (AuthenticationUtils.instance.isAuthenticating.value == true)
                    ElevatedButton(
                      onPressed: () {
                        AuthenticationUtils.instance.cancelAuthentication();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Cancel Authentication'),
                          Icon(Icons.cancel),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            AuthenticationUtils.instance.authenticate(context);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Authenticate'),
                              Icon(Icons.perm_device_information),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            AuthenticationUtils.instance.authenticateWithBiometrics();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(AuthenticationUtils.instance.isAuthenticating.value == true
                                  ? 'Cancel'
                                  : 'Authenticate: biometrics only'),
                              const Icon(Icons.security_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              )),
        );
      },
    );
  }
}
