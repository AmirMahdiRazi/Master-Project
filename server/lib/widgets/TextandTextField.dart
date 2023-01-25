// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextandTextField extends StatelessWidget {
  TextandTextField({
    super.key,
    required this.textEditingController,
    required this.def,
    required this.txt,
    this.count = 1,
    this.error,
    this.fouce = false,
  });
  Function(String) def;
  TextEditingController textEditingController = TextEditingController();
  String txt;
  int count;
  String? error;
  bool fouce;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: fouce,
              maxLines: 1,
              maxLength: count,
              onChanged: def,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              controller: textEditingController,
              style: const TextStyle(fontSize: 25, fontFamily: 'shadow'),
              decoration: InputDecoration(
                errorText: error,
                helperStyle: TextStyle(
                    fontSize: count == 1 ? 25 : 20,
                    fontFamily: 'shadow',
                    fontWeight: FontWeight.w600),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
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
        const SizedBox(
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
