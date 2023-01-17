import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/animation/button.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/server/base.dart';

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
  bool isClickable = true;
  late bool _stop;

  @override
  void initState() {
    _stop = false;
    Timer.periodic(Duration(seconds: 1), ((timer) {
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
                  label: 'HotSpotSSID',
                  help: 'HotSpotSSID',
                  icon: Icons.wifi_tethering,
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
                  pass: true,
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
                  children: [
                    Text(
                      "IP در دسترس",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontFamily: "bnazanin",
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: listIPS
                            .map(
                              (e) => AbsorbPointer(
                                absorbing: isClickable,
                                child: Container(
                                  height: 100,
                                  child: DesignedAnimatedButton(
                                      borderRadius: 30,
                                      height: 80,
                                      text: e,
                                      width: 500,
                                      onPress: () {
                                        Base().server.pass =
                                            widget.textControllerPassHot.text;
                                        Base().server.user =
                                            widget.textControllerSSIDHot.text;
                                        Base().server.ip = e.split(": ")[1];
                                        Base()
                                            .server
                                            .getUnusedPort(e.split(": ")[1]);
                                        Future.delayed(
                                            Duration(milliseconds: 505), () {
                                          Navigator.pushNamed(
                                              context, '/first');
                                        });
                                      }),
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
              children: [
                Text(
                  "لطفا hotspot را روشن کنید.",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: "bnazanin", fontSize: 30),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(),
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
