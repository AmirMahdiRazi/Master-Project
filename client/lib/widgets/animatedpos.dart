import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DesignAnimatedPositioned extends StatelessWidget {
  const DesignAnimatedPositioned(
      {super.key, required this.child, required this.start});
  final child;
  final start;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      child: child,
      duration: Duration(seconds: 1),
      // left: s ? 200 : 50,
      top: !start
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height / 2,
      right: MediaQuery.of(context).size.width / 2,
      width: 100,
      height: 100,
    );
  }
}
