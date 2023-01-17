import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/animation/button.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/server/base.dart';

class WifiPage extends StatefulWidget {
  WifiPage({super.key, required this.textControllerPassword});

  TextEditingController textControllerPassword;

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  String? wifiName, wifiIP;
  bool isNotClickable = true;
  late bool _stop;
  @override
  void initState() {
    _stop = false;
    isNotClickable = widget.textControllerPassword.text.toString().length >= 0
        ? false
        : true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_stop) timer.cancel();
      _ips();
    });

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
        future: _ips(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toString() == "true") {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "اسم Wifi: $wifiName",
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                DesignedTextField(
                  name: 'پسورد(Password)',
                  label: 'Password',
                  help: 'Password',
                  pass: true,
                  textEditingController: widget.textControllerPassword,
                  onChange: () {
                    setState(() {});
                    if (widget.textControllerPassword.text.isEmpty) {
                      isNotClickable = true;
                    } else {
                      isNotClickable = false;
                    }
                  },
                ),
                AbsorbPointer(
                  absorbing: isNotClickable,
                  child: DesignedAnimatedButton(
                      borderRadius: 30,
                      text: wifiIP ?? "error",
                      width: 300,
                      onPress: () {
                        Base().server.pass = widget.textControllerPassword.text;
                        Base().server.user = wifiName!;
                        Base().server.ip = wifiIP!;
                        Base().server.getUnusedPort(wifiIP!);
                        Future.delayed(const Duration(milliseconds: 505), () {
                          Navigator.pushNamed(context, '/first');
                        });
                      }),
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "لطفا Wifi را روشن کنید.",
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

  Future<bool> _ips() async {
    String temp = '';
    bool isWifiEnable = false;
    NetworkInfo info = NetworkInfo();
    try {
      wifiName = await info.getWifiName() ?? '';
      wifiIP = await info.getWifiIP() ?? '';
      if (wifiName!.isNotEmpty && wifiIP!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
