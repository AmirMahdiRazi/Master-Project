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
      repeatForever: true,
      pause: const Duration(seconds: 3),
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          speed: const Duration(seconds: 4),
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
          speed: const Duration(seconds: 4),
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

class TextAnimationFilicker extends StatelessWidget {
  const TextAnimationFilicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(milliseconds: 100),
          animatedTexts: [
            FlickerAnimatedText(
                'لطفا فایل دارای حداکثر 4 ستون باشد(نام، نام خانوادگی ، شماره دانشجویی)',
                textStyle:
                    const TextStyle(fontFamily: "bnazanin", fontSize: 30),
                speed: const Duration(seconds: 10)),
          ],
        ),
      ),
    );
  }
}
