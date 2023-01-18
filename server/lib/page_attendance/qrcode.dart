import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/server/base.dart';

// ignore: must_be_immutable
class QRGenearator extends StatefulWidget {
  QRGenearator({super.key, required this.size});

  int size;
  @override
  State<QRGenearator> createState() => _QRGenearatorState();
}

class _QRGenearatorState extends State<QRGenearator> {
  TextEditingController textEditingController = TextEditingController();

  late bool _stop;
  Random random = Random();
  @override
  void initState() {
    Base().server.ipConvert();
    _stop = false;
    Timer.periodic(const Duration(seconds: 30), (t) {
      Base().server.code = random.nextInt(9999).toString();
      if (_stop) {
        t.cancel();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _stop = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: QrImage(
            size: widget.size.toDouble(),
            data:
                '${Base().server.user}-${Base().server.pass}-${Base().server.ip}-${Base().server.port}-${Base().server.code}',
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
