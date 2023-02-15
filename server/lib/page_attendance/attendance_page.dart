import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:server/classes/courseandstudent.dart';

import 'package:server/classes/server.dart';
import 'package:server/constrant.dart';
import 'package:window_manager/window_manager.dart';

import 'bisection.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> with WindowListener {
  bool positive = true;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (Server().running &&
          Server().serverstatus == ServerStatuses.teminate) {
        setState(() {
          positive = true;
        });
        dialog();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    if (Server().running) Server().stopManual();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("نام درس:${Course().courseName}"),
            Text("جلسه:${Course().numberMeeting}"),
            Text(
              "IP:Port = ${Server().ip}:${Server().port}",
            )
          ],
        ),
        backgroundColor: Colors.amber,
        surfaceTintColor: Colors.blue,
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
              try {
                if (!Server().running) {
                  await ServerSocket.bind(Server().ip, Server().port)
                      .then((value) => value.close());
                }

                Server().startOrStop();
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  positive = !Server().running;
                });
              } catch (e) {
                dialog();
              }
            },
            colorBuilder: (b) => b ? Colors.red : Colors.green,
            iconBuilder: (value) => value
                ? const Icon(
                    Icons.power_settings_new_sharp,
                    size: 35,
                  )
                : const Icon(
                    Icons.power_settings_new_sharp,
                    size: 35,
                  ),
            textBuilder: (value) => value
                ? const Center(
                    child: Text(
                    'OFF',
                    style: TextStyle(
                        color: Colors.black, fontSize: 25, letterSpacing: 5),
                  ))
                : const Center(
                    child: Text('ON',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            letterSpacing: 5)),
                  ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF72326a),
                Color.fromARGB(255, 68, 0, 170),
              ],
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 103, 3, 233),
      body: const Bisection(),
    );
  }

  Future dialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "خطا",
          style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
          textAlign: TextAlign.right,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "IP سرور دچار مشکل شده است لطفا IP را بررسی کنید.",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
            ),
            Text(
              Server().ip,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(fontFamily: 'bnazanin', fontSize: 25),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text(
                "باشه",
                style: TextStyle(fontFamily: 'bnazanin', fontSize: 25),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/SelectIP', ModalRoute.withName('/selcetCourse'));
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text(
                textDirection: TextDirection.rtl,
                "برو به صفحه انتخاب IP",
                style: TextStyle(fontFamily: 'bnazanin', fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
