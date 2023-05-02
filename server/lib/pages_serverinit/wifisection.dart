import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/constrant.dart';
import 'package:server/widgets/button.dart';
import 'package:server/pages_serverinit/textfield.dart';
import 'package:server/classes/server.dart';

// ignore: must_be_immutable
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
    // ignore: prefer_is_empty
    isNotClickable = widget.textControllerPassword.text.toString().length >= 0
        ? false
        : true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stop) timer.cancel();
      _ips();
      setState(() {});
      
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
                  "WifiName: $wifiName",
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sofia'),
                ),
                DesignedTextField(
                  name: 'پسورد(Password)',
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
                      fontFamily: '',
                      fSize: 40,
                      text: wifiIP ?? "error",
                      width: 300,
                      height: 100,
                      onPress: () {
                        Server().pass = widget.textControllerPassword.text;
                        Server().user = wifiName!;
                        Server().ip = wifiIP!;
                        Server().getUnusedPort(wifiIP!);
                        Future.delayed(const Duration(milliseconds: 505), () {
                          Server().serverstatus = ServerStatuses.normal;
                          Navigator.pushNamed(context, '/Attendance');
                        });
                      }),
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "لطفا به یک Wifi متصل شوید.",
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
