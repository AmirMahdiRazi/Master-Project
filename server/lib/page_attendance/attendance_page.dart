import 'package:flutter/material.dart';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:server/server/base.dart';

import 'bisection.dart';

class Attend extends StatefulWidget {
  const Attend({super.key});

  @override
  State<Attend> createState() => _AttendState();
}

class _AttendState extends State<Attend> {
  bool positive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Base().server.startOrStop();
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                positive = !Base().server.running;
              });
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
}
