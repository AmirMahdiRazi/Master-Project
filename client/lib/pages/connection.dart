// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:client/backgroundwidget.dart';
import 'package:client/pages/qrcodescanner.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<Map<String, String>> _statusChecker =
    ValueNotifier({"Wifi": "off", "Vpn": "on"});

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  List<bool> previousState = [false, true];
  @override
  void initState() {
    checkWifi();
    super.initState();
  }

  @override
  void dispose() {
    // _statusChecker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: ValueListenableBuilder(
          valueListenable: _statusChecker,
          builder: ((context, value, child) {
            return !mapEquals(value, {"Wifi": "on", "Vpn": "off"})
                ? const WifiandVpnChecker()
                : const QRCodeScanner();
          })),
    );
  }

  void checkWifi() async {
    Timer.periodic(const Duration(milliseconds: 500), (Timer timer) async {
      bool statusWifi = await WiFiForIoTPlugin.isEnabled();
      bool statusVpn = await CheckVpnConnection.isVpnActive();
      if (previousState[0] != statusWifi || previousState[1] != statusVpn) {
        previousState[0] = statusWifi;
        previousState[1] = statusVpn;
        checker(statusWifi, statusVpn);
      }
    });
  }

  void checker(bool statusWifi, bool statusVpn) {
    if (statusWifi == true && statusVpn == false) {
      _statusChecker.value = {"Wifi": "on", "Vpn": "off"};
    } else if (statusWifi == false && statusVpn == true) {
      _statusChecker.value = {"Wifi": "off", "Vpn": "on"};
    } else if (statusWifi == false) {
      _statusChecker.value = {"Wifi": "off", "Vpn": "off"};
    } else {
      _statusChecker.value = {"Wifi": "on", "Vpn": "on"};
    }
  }
}

class WifiandVpnChecker extends StatefulWidget {
  const WifiandVpnChecker({super.key});

  @override
  State<WifiandVpnChecker> createState() => _WifiandVpnCheckerState();
}

class _WifiandVpnCheckerState extends State<WifiandVpnChecker> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Map<String, String>>(
          valueListenable: _statusChecker,
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: value["Wifi"] == 'off',
                    child: ChangeStatus(
                        description: 'Wifi را روشن کنید',
                        function: () {
                          OpenSettings.openWirelessSetting();
                        }),
                  ),
                  const SizedBox(height: 40),
                  Visibility(
                    visible: value["Vpn"] == 'on',
                    child: ChangeStatus(
                        description: 'Vpn را خاموش کنید',
                        function: () {
                          OpenSettings.openVPNSetting();
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class ChangeStatus extends StatefulWidget {
  const ChangeStatus(
      {super.key, required this.description, required this.function});
  final String description;
  final Function function;
  @override
  State<ChangeStatus> createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child:
              Text(widget.description, style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(
          height: 25,
        ),
        CircleAvatar(
          radius: 60,
          backgroundColor: const Color.fromARGB(139, 0, 213, 35),
          child: IconButton(
            iconSize: 100,
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            icon: const Icon(
              size: 50,
              Icons.power_settings_new_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              widget.function();
            },
          ),
        ),
      ],
    );
  }
}
