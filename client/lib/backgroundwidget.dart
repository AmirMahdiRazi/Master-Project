// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({Key? key, this.child}) : super(key: key);
  final child;

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            RotatedBox(
              quarterTurns: 45,
              child: Lottie.asset('assets/background.json'),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: widget.child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
