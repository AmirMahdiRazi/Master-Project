import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:server/animation/button.dart';
import 'package:server/page_initalapp/coursename.dart';

class TextAndTextField extends StatefulWidget {
  TextAndTextField({super.key, required this.datas});
  List<List<String>> datas = [];
  @override
  State<TextAndTextField> createState() => _TextAndTextFieldState();
}

class _TextAndTextFieldState extends State<TextAndTextField> {
  TextEditingController _textEditingControllerFName = TextEditingController();
  TextEditingController _textEditingControllerLName = TextEditingController();
  TextEditingController _textEditingControllerStdNumber =
      TextEditingController();
  TextEditingController _textControllerCourse = TextEditingController();
  bool _isNotClickAble = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  color: Colors.white,
                  child: TextField(
                    onChanged: checker_Input,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    controller: _textEditingControllerFName,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                Text(
                  " : ستون نام",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "bnazanin",
                      fontSize: 30),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  color: Colors.white,
                  child: TextField(
                    onChanged: checker_Input,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    controller: _textEditingControllerLName,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                Text(
                  " : ستون نام خانوادگی",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "bnazanin",
                      fontSize: 30),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  color: Colors.white,
                  child: TextField(
                    onChanged: checker_Input,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    controller: _textEditingControllerStdNumber,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                Text(
                  " : ستون شماره دانشجویی",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "bnazanin",
                      fontSize: 30),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        CourseName(
          function: checker_Input,
          textEditingController: _textControllerCourse,
        ),
        SizedBox(
          height: 50,
        ),
        AbsorbPointer(
          absorbing: _isNotClickAble,
          child: DesignedAnimatedButton(
            text: "Save",
            onPress: () {
              int fName = int.parse(_textEditingControllerFName.text),
                  lName = int.parse(_textEditingControllerLName.text),
                  stdNumber = int.parse(_textEditingControllerStdNumber.text);
              List<List<String>> temp;
              int index = 1;
              temp = widget.datas
                  .map((e) =>
                      ["${index++}", e[fName], e[lName], e[stdNumber], "0"])
                  .toList();
              Excel excel = Excel.createExcel();
              Sheet sheetObject = excel["Sheet1"];
              index = 0;
              temp
                  .map((e) => sheetObject.insertRowIterables(e, index++))
                  .toList();

              var directory = '../../Datas/${_textControllerCourse.text}';
              var fileBytes = excel.save();
              try {
                File("$directory/${_textControllerCourse.text}.xlsx")
                  ..createSync(recursive: true)
                  ..writeAsBytesSync(fileBytes!);
              } catch (e) {
                print("error");
              }
              print("done");
            },
          ),
        )
      ],
    );
  }

  void checker_Input(String value) {
    bool fill = _textControllerCourse.text.isNotEmpty &&
        _textEditingControllerFName.text.isNotEmpty &&
        _textEditingControllerLName.text.isNotEmpty &&
        _textEditingControllerStdNumber.text.isNotEmpty;
    if (fill) {
      _isNotClickAble = false;
      setState(() {});
    } else {
      _isNotClickAble = true;
      setState(() {});
    }
  }
}
