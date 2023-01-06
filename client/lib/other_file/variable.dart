import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool isCheck = false;

const kTextFieldDecoration = InputDecoration(
  suffixIcon: Icon(Icons.numbers),
  hintTextDirection: TextDirection.rtl,
  labelStyle: TextStyle(textBaseline: TextBaseline.ideographic),
  labelText: 'شماره دانشجویی',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 236, 236, 236), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 34), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

TextStyle kAnimatedButton = GoogleFonts.nunito(
    fontSize: 20,
    color: Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.w300);
