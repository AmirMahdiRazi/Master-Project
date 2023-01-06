import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Success extends StatelessWidget {
  const Success({super.key, this.code, this.description});
  final code;
  final description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Lottie.asset('assets/tagalong-pro-success.json'),
          ),
          Text(
            '$description : توضیحات',
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
            '$code : با کد',
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
      ),
    );
  }
}
