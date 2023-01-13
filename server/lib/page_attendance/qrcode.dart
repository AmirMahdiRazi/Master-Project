
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Page_QR extends StatefulWidget {
  const Page_QR({super.key});

  @override
  State<Page_QR> createState() => _Page_QRState();
}

class _Page_QRState extends State<Page_QR> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: QrImage(
            size: 500,
            data: textEditingController.text,
            backgroundColor: Colors.white,
          ),
        ),
        TextField(
          controller: textEditingController,
          onChanged: (value)=> setState(() {

          }),
        )
      ],
    );
  }
}
