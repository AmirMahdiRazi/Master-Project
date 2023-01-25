// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'package:server/widgets/button.dart';
import 'package:server/page_createcourse/coursename.dart';
import 'package:server/widgets/TextandTextField.dart';
import 'package:server/classes/base.dart';

class Details extends StatefulWidget {
  Details({super.key, required this.datas});
  List<List<String>> datas = [];
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController _textEditingControllerFName =
      TextEditingController();
  final TextEditingController _textEditingControllerLName =
      TextEditingController();
  final TextEditingController _textEditingControllerStdNumber =
      TextEditingController();
  final TextEditingController _textControllerCourse = TextEditingController();
  bool _isNotClickAble = true;
  // ignore: non_constant_identifier_names
  String directory_path = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextandTextField(
                textEditingController: _textEditingControllerFName,
                def: checkerInput,
                txt: 'ستون نام: '),
            TextandTextField(
                textEditingController: _textEditingControllerLName,
                def: checkerInput,
                txt: 'ستون نام خانوادگی: '),
            TextandTextField(
                textEditingController: _textEditingControllerStdNumber,
                def: checkerInput,
                txt: 'ستون شماره دانشجویی: ')
          ],
        ),
        CourseName(
          function: checkerInput,
          textEditingController: _textControllerCourse,
        ),
        const SizedBox(
          height: 10,
        ),
        AbsorbPointer(
          absorbing: _isNotClickAble,
          child: DesignedAnimatedButton(
            borderRadius: 30,
            width: 200,
            height: 65,
            text: "ذخیره",
            onPress: () async {
              int fName = int.parse(_textEditingControllerFName.text),
                  lName = int.parse(_textEditingControllerLName.text),
                  stdNumber = int.parse(_textEditingControllerStdNumber.text);
              List<List<String>> temp;
              int index = 1;
              widget.datas.removeAt(0);
              temp = widget.datas
                  .map((e) => [
                        "${index++}",
                        e[fName],
                        e[lName],
                        e[stdNumber],
                        "0",
                        "0",
                        "0",
                        "0"
                      ])
                  .toList();
              writeOnExcel(temp);
            },
          ),
        )
      ],
    );
  }

  void writeOnExcel(List<List<String>> temp) async {
    Excel excel = Excel.createExcel();
    excel.rename("Sheet1", "booksheet 1");
    Sheet sheetObject = excel["booksheet 1"];
    int index = 0;
    temp.map((e) => sheetObject.insertRowIterables(e, index++)).toList();
    for (int i = 0; i <= 32; i++) {
      excel.copy("booksheet 1", "booksheet $i");
    }

    var fileBytes = excel.save();
    String path = "${Base().path}/Datas/${_textControllerCourse.text}/";
    try {
      File("${path}/${_textControllerCourse.text}.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      File('${path}/${_textControllerCourse.text}.txt').createSync();
      Navigator.popAndPushNamed(context, '/selcetCourse');
    } catch (e) {
      await Future.delayed(Duration(milliseconds: 50));
      dialog();
    }
  }

  void checkerInput(String value) {
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

  Future dialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "خطا",
          style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
          textAlign: TextAlign.right,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "لطفا فایل Excel را ببندید.",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
            ),
            Text(directory_path),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text(
                "باشه",
                style: TextStyle(fontFamily: 'bnazanin', fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
