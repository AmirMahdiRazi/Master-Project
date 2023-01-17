import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:server/animation/button.dart';
import 'package:server/page_initalapp/coursename.dart';
import 'package:server/page_initalapp/filepickerandtable.dart';
import 'package:server/page_initalapp/textandtextfield.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _textControllerFile = TextEditingController();
  TextEditingController _textControllerCourse = TextEditingController();
  List<List<String>> listData = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        filePicker(),
        listData.isNotEmpty
            ? table()
            : Container(
                color: Colors.white,
                child: Text(
                  "لطفا مسیر فایل اکسل را انتخاب کنید",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'bnazanin',
                      fontWeight: FontWeight.bold),
                ),
              ),
        listData.isNotEmpty ? TextAndTextField(datas: listData) : SizedBox(),
      ],
    );
  }

  Widget filePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          width: 700,
          height: 50,
          child: TextField(
            readOnly: true,
            controller: _textControllerFile,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
          ),
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: Container(
            child: IconButton(
              color: Colors.white,
              splashRadius: 1,
              iconSize: 25,
              onPressed: _pickerFile,
              icon: Icon(Icons.folder_open),
            ),
          ),
        )
      ],
    );
  }

  void _pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowedExtensions: ['xlsx'],
    );
    if (result == null) return;
    PlatformFile file = result.files.single;
    setState(() {});
    _textControllerFile.text = file.path.toString();
    try {
      var file = _textControllerFile.text;
      var bytes = File(file).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      for (var row in excel.tables[excel.tables.keys.first]!.rows) {
        listData.add(row.map((e) => e!.value.toString()).toList());
      }
    } catch (e) {}
  }

  Widget table() {
    return Column(
      children: [
        Container(
          height: 50,
          child: ListView(
            children: [
              Container(
                height: 50,
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        listData[0].length,
                        (index) => Text(
                              "ستون : $index",
                              textAlign: TextAlign.center,
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: listData.length,
            itemBuilder: ((context, index) {
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: listData[index].map((e) => Text("$e")).toList(),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
