import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/animation/button.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/server/server.dart';

class WifiPage extends StatefulWidget {
  WifiPage({super.key, required this.textEditingControllerPassword});

  TextEditingController textEditingControllerPassword;

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  String? wifiName, wifiIP;
  bool isClickable = true;
  @override
  void initState() {
    ips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: ips(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  wifiName ?? 'Error',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                DesignedTextField(
                  name: 'پسورد(Password)',
                  label: 'Password',
                  help: 'Password',
                  textEditingController: widget.textEditingControllerPassword,
                  onChange: () {
                    setState(() {});
                    if (widget.textEditingControllerPassword.text.isEmpty) {
                      isClickable = true;
                    } else {
                      isClickable = false;
                    }
                  },
                ),
                AbsorbPointer(
                  absorbing: isClickable,
                  child: DesignedAnimatedButton(
                      text: wifiIP ?? "error",
                      width: 200,
                      onPress: () {
                        Server().pass =
                            widget.textEditingControllerPassword.text;
                        Server().user = wifiName!;
                        Server().ip = wifiIP!;
                      }),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<bool> ips() async {
    String temp = '';
    bool isWifiEnable = false;
    NetworkInfo info = NetworkInfo();
    try {
      wifiName = await info.getWifiName() ?? '';
      wifiIP = await info.getWifiIP() ?? '';

      return true;
    } catch (e) {
      return false;
    }
  }
}
