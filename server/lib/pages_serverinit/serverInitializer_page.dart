import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/pages_serverinit/hotspotsection.dart';
import 'package:server/pages_serverinit/wifisection.dart';
import 'package:server/classes/server.dart';
import '../constrant.dart';

class ServerInit extends StatefulWidget {
  const ServerInit({super.key});

  @override
  State<ServerInit> createState() => _ServerInitState();
}

enum _Stauts { wifi, hotspot }

class _ServerInitState extends State<ServerInit> {
  late List<List<String>> ethernet;
  TextEditingController textControllerPasswordWifi = TextEditingController();
  TextEditingController textControllerSSIDHot = TextEditingController();
  TextEditingController textControllerPassHot = TextEditingController();
  Future<StatusConnection> state = Server().checkWifi();
  final info = NetworkInfo();
  bool positive = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 25,
        title: const Text(
          'انتخاب IP',
          style: TextStyle(
              fontFamily: 'bnazanin',
              fontWeight: FontWeight.bold,
              fontSize: 25),
          textDirection: TextDirection.rtl,
        ),
        actions: [
          AnimatedToggleSwitch<bool>.dual(
            current: positive,
            first: false,
            second: true,
            dif: 50.0,
            borderColor: Colors.black.withAlpha(255),
            borderWidth: 5.0,
            height: 55,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
            onChanged: (b) async {
              checker();

              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                positive = Server().connection == StatusConnection.hotspot
                    ? true
                    : false;
              });
            },
            colorBuilder: (b) => b ? Colors.red : Colors.green,
            iconBuilder: (value) => value
                ? const Icon(Icons.wifi)
                : const Icon(Icons.wifi_tethering),
            textBuilder: (value) => value
                ? const Center(
                    child: Text(
                    'Hotspot',
                    style: TextStyle(color: Colors.black),
                  ))
                : const Center(
                    child: Text('Wifi', style: TextStyle(color: Colors.black)),
                  ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<StatusConnection>(
            future: state,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!positive) {
                  return WifiPage(
                    textControllerPassword: textControllerPasswordWifi,
                  );
                } else {
                  return HotspotPage(
                    textControllerPassHot: textControllerPassHot,
                    textControllerSSIDHot: textControllerSSIDHot,
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<void> checker() async {
    await Server().checkWifi();
  }
}
