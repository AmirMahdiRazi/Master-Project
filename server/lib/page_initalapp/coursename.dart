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
        const Text(
          "نام درس:",
          style: TextStyle(
              color: Colors.white, fontFamily: "bnazanin", fontSize: 30),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          color: Colors.white,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: widget.function,
              decoration: const InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
              controller: widget.textEditingController,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ],
    );
  }
}
