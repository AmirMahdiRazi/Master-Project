import 'package:flutter/material.dart';

class CourseName extends StatefulWidget {
  CourseName(
      {super.key, required this.textEditingController, required this.function});
  TextEditingController textEditingController = TextEditingController();
  Function(String) function;
  @override
  State<CourseName> createState() => _CourseNameState();
}

class _CourseNameState extends State<CourseName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "نام درس:",
          style: TextStyle(
              color: Colors.white, fontFamily: "bnazanin", fontSize: 30),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          color: Colors.white,
          width: 300,
          child: TextField(
            onChanged: widget.function,
            controller: widget.textEditingController,
            style: TextStyle(fontSize: 28),
          ),
        ),
      ],
    );
  }
}
