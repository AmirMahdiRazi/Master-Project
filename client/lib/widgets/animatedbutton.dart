import 'package:client/other_file/variable.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignedAnimatedButton extends StatelessWidget {
  const DesignedAnimatedButton({
    super.key,
    required this.text,
    required this.onPress,
    this.height = 50,
    this.width = 120,
    this.borderRadius = 0,
  });
  final String text;
  final VoidCallback onPress;
  final double height;
  final double width;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      borderRadius: borderRadius,
      onPress: onPress,
      height: height,
      width: width,
      text: text,
      gradient: LinearGradient(colors: [
        Color.fromARGB(139, 0, 253, 0),
        Color.fromARGB(137, 0, 255, 242)
      ]),
      selectedGradientColor:
          LinearGradient(colors: [Colors.pinkAccent, Colors.purpleAccent]),
      isReverse: true,
      selectedTextColor: Colors.black,
      transitionType: TransitionType.LEFT_CENTER_ROUNDER,
      textStyle: kAnimatedButton,
      borderColor: Colors.white,
      borderWidth: 1,
    );
  }
}
