import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:server/classes/server.dart';

// ignore: must_be_immutable
class QRGenerator extends StatefulWidget {
  QRGenerator({super.key, required this.size});

  int size;
  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  TextEditingController textEditingController = TextEditingController();
  late String plainText;
  late bool _stop;
  late String text;
  Random random = Random();
  @override
  void initState() {
    Server().code = random.nextInt(99999999).toString();
    Server().ipConvert();
    plainText =
        '${Server().ssid}-${Server().pass}-${Server().ipConvert()}-${Server().port}-${Server().code}';
    text = Server().encrypt.encrypt(plainText);
    _stop = false;
    Timer.periodic(const Duration(seconds: 30), (t) {
      if (Server().running) {
        Server().code = random.nextInt(99999999).toString();
        plainText =
            '${Server().ssid}-${Server().pass}-${Server().ipConvert()}-${Server().port}-${Server().code}';
        text = Server().encrypt.encrypt(plainText);
      }

      if (_stop) {
        t.cancel();
      } else {
        setState(() {});
      }
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
            data: text,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
