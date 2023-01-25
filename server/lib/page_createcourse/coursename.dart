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
        Container(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: TextField(
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                onChanged: widget.function,
                controller: widget.textEditingController,
                style: const TextStyle(fontSize: 28, color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 2, 2, 2), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 255, 34), width: 2.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Text(
          textDirection: TextDirection.rtl,
          "نام درس:",
          style: TextStyle(
              color: Colors.black, fontFamily: "bnazanin", fontSize: 30),
        ),
      ],
    );
  }
}
