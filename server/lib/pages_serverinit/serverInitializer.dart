import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/animation/button.dart';
import 'package:server/animation/toggle.dart';
import 'package:server/globalvariable.dart';
import 'package:server/pages_serverinit/hotspotsection.dart';
import 'package:server/pages_serverinit/wifisection.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/server/server.dart';

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
  Future<Status> state = Server().checkWifi();
  final info = NetworkInfo();
  _Stauts _stauts = _Stauts.hotspot;
  bool positive = true;

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
              setState(() {
                positive = Server().connection == Status.hotspot ? false : true;
              });
              await Future.delayed(Duration(seconds: 1));
            },
            colorBuilder: (b) => b ? Colors.red : Colors.green,
            iconBuilder: (value) =>
                value ? Icon(Icons.wifi) : Icon(Icons.wifi_tethering),
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
        child: FutureBuilder<Status>(
            future: state,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!positive) {
                  return WifiPage(
                    textEditingControllerPassword: textControllerPasswordWifi,
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

  Future<int> getUnusedPort(String address) async {
    int port = await ServerSocket.bind(address, 0).then((socket) {
      var port = socket.port;
      socket.close();
      return port;
    });
    setState(() {});
    if (port >= 0) {
      return port;
    } else {
      return -1;
    }
  }
}
