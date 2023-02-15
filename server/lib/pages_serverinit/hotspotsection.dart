// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/constrant.dart';
import 'package:server/widgets/button.dart';
import 'package:server/pages_serverinit/textfield.dart';

import 'package:server/classes/server.dart';

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
  String listIP = '';

  String ethernet = '';
  List<String> listIPS = [];
  bool isNotClickable = true;
  late bool _stop;

  @override
  void initState() {
    _stop = false;
    Timer.periodic(const Duration(seconds: 1), ((timer) {
      if (_stop) {
        timer.cancel();
      }
      _ips();
    }));

    super.initState();
  }

  @override
  void dispose() {
    _stop = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: checker(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toString().isNotEmpty) {
            listIPS = clean(snapshot.data.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DesignedTextField(
                  name: 'نام هات اسپات(Hotspot SSID)',
                  help: 'HotSpotSSID',
                  icon: Icons.wifi_tethering,
                  textEditingController: widget.textControllerSSIDHot,
                  onChange: () {
                    setState(() {});
                    if (widget.textControllerPassHot.text.isEmpty ||
                        widget.textControllerSSIDHot.text.isEmpty) {
                      isNotClickable = true;
                    } else {
                      isNotClickable = false;
                    }
                  },
                ),
                DesignedTextField(
                  name: 'پسورد(Password)',
                  help: 'Password',
                  pass: true,
                  textEditingController: widget.textControllerPassHot,
                  onChange: () {
                    setState(() {});
                    if (widget.textControllerPassHot.text.isEmpty ||
                        widget.textControllerSSIDHot.text.isEmpty) {
                      isNotClickable = true;
                    } else {
                      isNotClickable = false;
                    }
                  },
                ),
                Column(
                  children: [
                    const Text(
                      "IP در دسترس",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontFamily: "bnazanin",
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                        children: listIPS
                            .map(
                              (e) => AbsorbPointer(
                                absorbing: isNotClickable,
                                child: SizedBox(
                                  height: 80,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: DesignedAnimatedButton(
                                        duration: 3000,
                                        height: 80,
                                        text: e,
                                        width: 500,
                                        onPress: () {
                                          setState(() {});
                                          isNotClickable = true;
                                          Server().pass =
                                              widget.textControllerPassHot.text;
                                          Server().user =
                                              widget.textControllerSSIDHot.text;
                                          Server().ip = e.split(": ")[1];

                                          Future.delayed(
                                              const Duration(seconds: 3), () {
                                            Server().getUnusedPort(
                                                e.split(": ")[1]);
                                            Server().serverstatus =
                                                ServerStatuses.normal;
                                            setState(() {});
                                            isNotClickable = false;
                                            Navigator.pushNamed(
                                                context, '/Attendance');
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ],
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "لطفا hotspot را روشن کنید.",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: "bnazanin", fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                const CircularProgressIndicator(),
              ],
            );
          }
        });
  }

  List<String> clean(String data) {
    return data.split('*-*').map((e) => e).toList();
  }

  Future<void> _ips() async {
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
      _ips();
      await Future.delayed(const Duration(seconds: 1));

      return listIP;
    } else {
      return listIP;
    }
  }
}
