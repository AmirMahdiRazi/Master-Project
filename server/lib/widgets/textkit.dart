import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DesignAnimatedTextKit extends StatelessWidget {
  const DesignAnimatedTextKit(
      {super.key, required this.text, this.fontsize = 15});
  final String text;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 10,
      repeatForever: true,
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          speed: const Duration(seconds: 2),
          textStyle: TextStyle(
            fontSize: fontsize,
            fontFamily: 'bnazanin',
          ),
          colors: [
            Colors.purple,
            const Color.fromARGB(255, 6, 194, 62),
            Colors.yellow,
            const Color.fromARGB(255, 5, 243, 211),
          ],
        ),
        ColorizeAnimatedText(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          speed: const Duration(seconds: 2),
          textStyle: TextStyle(
            fontSize: fontsize,
            fontFamily: 'bnazanin',
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
