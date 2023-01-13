import 'package:flutter/material.dart';
import 'package:server/globalvariable.dart';
import 'package:server/server/server.dart';

class Bisection extends StatefulWidget {
  const Bisection({super.key});

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 103, 3, 233),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: 300,
            color: Color.fromARGB(255, 103, 3, 233),
          ),
        )
      ],
    );
  }
}
