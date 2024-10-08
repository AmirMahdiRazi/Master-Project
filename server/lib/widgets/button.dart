import 'package:flutter_animated_button/flutter_animated_button.dart';

import 'package:flutter/material.dart';

class DesignedAnimatedButton extends StatelessWidget {
  DesignedAnimatedButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.height = 50,
      this.width = 120,
      this.fSize = 25,
      this.fontFamily = 'bnazanin',
      this.bRadius = 30.0,
      this.duration = 500});
  final String text;
  final VoidCallback onPress;
  final double height;
  final double width;
  final double bRadius;
  final double fSize;
  final String fontFamily;
  final int duration;
  bool _isNotClickAble = false;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _isNotClickAble,
      child: AnimatedButton(
        borderRadius: bRadius,
        onPress: () async {
          _isNotClickAble = true;
          await Future.delayed(const Duration(milliseconds: 505));
          onPress();
          _isNotClickAble = false;
        },
        animationDuration: Duration(milliseconds: duration),
        height: height,
        width: width,
        text: text,
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fSize,
            fontFamily: fontFamily),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(139, 0, 253, 0),
          Color.fromARGB(137, 0, 255, 242)
        ]),
        selectedGradientColor: const LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent]),
        isReverse: true,
        selectedTextColor: Colors.black,
        transitionType: TransitionType.LEFT_CENTER_ROUNDER,
        borderColor: Colors.white,
        borderWidth: 1,
      ),
    );
  }
}
