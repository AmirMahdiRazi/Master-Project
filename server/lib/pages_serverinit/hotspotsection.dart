import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/animation/button.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/server/server.dart';

class HotspotPage extends StatefulWidget {
  HotspotPage({
    super.key,
    required this.textControllerSSIDHot,
    required this.textControllerPassHot,
  });

  TextEditingController textControllerSSIDHot, textControllerPassHot;

  final info = NetworkInfo();
  @override
  State<HotspotPage> createState() => _HotspotPageState();
}

class _HotspotPageState extends State<HotspotPage> {
  String? wifiName, wifiIP;
  String listIP = '';
  late Future<String> IPS;
  String ethernet = '';
  List<String> listIPS = [];
  bool isClickable = true;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), ((timer) => ips()));

    IPS = checker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: IPS,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            listIPS = clean(snapshot.data.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DesignedTextField(
                  name: 'نام هات اسپات(Hotspot SSID)',
                  label: 'HotSpotSSID',
                  help: 'HotSpotSSID',
                  textEditingController: widget.textControllerSSIDHot,
                  onChange: () {
                    setState(() {});
                    if (widget.textControllerPassHot.text.isEmpty ||
                        widget.textControllerSSIDHot.text.isEmpty) {
                      isClickable = true;
                    } else {
                      isClickable = false;
                    }
                  },
                ),
                DesignedTextField(
                  name: 'پسورد(Password)',
                  label: 'Password',
                  help: 'Password',
                  textEditingController: widget.textControllerPassHot,
                  onChange: () {
                    setState(() {});
                    if (widget.textControllerPassHot.text.isEmpty ||
                        widget.textControllerSSIDHot.text.isEmpty) {
                      isClickable = true;
                    } else {
                      isClickable = false;
                    }
                  },
                ),
                Column(
                    children: listIPS
                        .map(
                          (e) => AbsorbPointer(
                            absorbing: isClickable,
                            child: DesignedAnimatedButton(
                                text: e,
                                width: 300,
                                onPress: () {
                                  if (widget.textControllerSSIDHot.text
                                          .isNotEmpty &&
                                      widget.textControllerPassHot.text
                                          .isNotEmpty) {
                                  } else {}
                                }),
                          ),
                        )
                        .toList())
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  List<String> clean(String data) {
    return data.split('*-*').map((e) => e).toList();
  }

  Future<void> ips() async {
    String temp = '';

    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type.name == 'IPv4' &&
            (interface.name.toLowerCase().contains("ethernet") ||
                interface.name.toLowerCase().contains('*'))) {
          if (temp.isEmpty) {
            temp = '${interface.name}: ${addr.address}';
          } else {
            temp = '$temp*-*${interface.name}: ${addr.address}';
          }
        }
        break;
      }
    }
    if (listIP != temp) {
      listIP = temp;
      checker();
    }
  }

  Future<String> checker() async {
    setState(() {});
    if (listIP.isEmpty) {
      ips();
      await Future.delayed(const Duration(seconds: 1));

      return listIP;
    } else {
      return listIP;
    }
  }
}
