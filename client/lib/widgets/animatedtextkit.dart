// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DesignAnimatedTextKit extends StatelessWidget {
  const DesignAnimatedTextKit(
      {super.key, required this.text, this.fontsize = 15});
  final text;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          speed: const Duration(seconds: 1),
          textStyle: TextStyle(
            fontSize: fontsize,
            fontFamily: 'Horizon',
          ),
          colors: [
            Colors.purple,
            const Color.fromARGB(255, 6, 194, 62),
            Colors.yellow,
            Colors.red,
          ],
        ),
        ColorizeAnimatedText(
          text,
          textAlign: TextAlign.right,
          speed: const Duration(seconds: 1),
          textStyle: TextStyle(
            fontSize: fontsize,
            fontFamily: 'Horizon',
          ),
          colors: [
            Colors.purple,
            const Color.fromARGB(255, 6, 194, 62),
            Colors.yellow,
            Colors.red,
          ],
        ),
      ],
    );
  }
}
