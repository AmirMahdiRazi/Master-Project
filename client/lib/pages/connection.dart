import 'dart:async';

import 'dart:isolate';

import 'package:client/pages/qrcodescanner.dart';
// import 'package:client/pages/wifi_connection.dart';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

ValueNotifier<bool> wifiChecker = ValueNotifier(false);
bool isWifiEnable = false;

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  void initState() {
    checkWifi();
    super.initState();
  }

  @override
  void dispose() {
    wifiChecker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: wifiChecker,
        builder: ((context, value, child) {
          return value ? const QRCodeScanner() : const Enable_Wifi();
        }));
  }

  void checkWifi() async {
    Timer.periodic(const Duration(milliseconds: 500), (Timer timer) async {
      isWifiEnable = wifiChecker.value;
      bool statusWifi = await WiFiForIoTPlugin.isEnabled();
      if (statusWifi != isWifiEnable) {
        wifiChecker.value = statusWifi;
        isWifiEnable = statusWifi;
      }
    });
  }
}

class Enable_Wifi extends StatefulWidget {
  const Enable_Wifi({super.key});

  @override
  State<Enable_Wifi> createState() => _Enable_WifiState();
}

class _Enable_WifiState extends State<Enable_Wifi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Text('لطفا وای فای خود را روشن کنید '),
            ),
            const Divider(
              color: Colors.blueAccent,
              height: 2,
              thickness: 5,
              indent: 25,
              endIndent: 25,
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
                  Icons.wifi_off_sharp,
                  color: Colors.black,
                ),
                onPressed: () async {
                  WiFiForIoTPlugin.setEnabled(false, shouldOpenSettings: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
