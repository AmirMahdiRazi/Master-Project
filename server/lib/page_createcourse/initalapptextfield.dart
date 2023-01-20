// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextandTextField extends StatelessWidget {
  TextandTextField({
    super.key,
    required this.textEditingController,
    required this.def,
    required this.txt,
  });
  Function(String) def;
  TextEditingController textEditingController = TextEditingController();
  String txt;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 1,
              maxLength: 1,
              onChanged: def,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              controller: textEditingController,
              style: const TextStyle(fontSize: 30),
              decoration: InputDecoration(
                errorText: error,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 2, 2, 2), width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 255, 34), width: 2.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          txt,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              color: Colors.black, fontFamily: "bnazanin", fontSize: 30),
        ),
      ],
    );
  }
}
