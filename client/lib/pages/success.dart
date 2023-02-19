// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:client/classes/transfer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Success extends StatelessWidget {
  const Success({super.key, this.code, this.description});
  final code;
  final description;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child:
              Lottie.asset('assets/tagalong-pro-success.json', repeat: false),
        ),
        Text(
          '${TransferData().client.result!["result"]}',
          textAlign: TextAlign.right,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        Text(
          'حاضری شما زده شد.',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
