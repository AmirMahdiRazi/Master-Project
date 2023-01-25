import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:server/classes/server.dart';

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
    Server().code = random.nextInt(9999).toString();
    print(Server().code);
    Server().ipConvert();
    print(Server().port);
    _stop = false;
    Timer.periodic(const Duration(hours: 1), (t) {
      Server().code = random.nextInt(9999).toString();
      print(
          '${Server().user}-${Server().pass}-${Server().ipConvert()}-${Server().port}-${Server().code}');
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
                '${Server().user}-${Server().pass}-${Server().ipConvert()}-${Server().port}-${Server().code}',
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
