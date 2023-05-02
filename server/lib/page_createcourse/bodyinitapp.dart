import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:server/widgets/textkit.dart';
import 'package:server/page_createcourse/Details.dart';
import 'package:server/page_createcourse/table.dart';
import 'package:window_manager/window_manager.dart';

class BodyInitApp extends StatefulWidget {
  const BodyInitApp({super.key});

  @override
  State<BodyInitApp> createState() => _BodyInitAppState();
}

class _BodyInitAppState extends State<BodyInitApp> with WindowListener {
  final TextEditingController _textControllerFile = TextEditingController();
  List<List<String>> listData = [];
  bool _isNotClickAble = false;
  bool? _lastState = false;
  var fileExcelPath = '';
// ??
  @override
  void initState() {
    if (!Navigator.canPop(context)) {
      windowManager.addListener(this);
      _lastState = false;
      _init();
    }
    super.initState();
  }

// ??

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (_lastState != true && isPreventClose) {
      _lastState = true;
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'آیا می خواهید برنامه را ببندید؟',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.right,
            ),
            actions: [
              TextButton(
                child: const Text(
                  'نه',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  _lastState = false;
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'بله',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                  textAlign: TextAlign.right,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

// ??

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        filePicker(),
        listData.isNotEmpty
            ? DesginedTable(
                files: listData,
              )
            : Container(
                color: Colors.white.withOpacity(.2),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DesignAnimatedTextKit(
                    text: ".را انتخاب کنید excel لطفا مسیر فایل ",
                    fontsize: 50,
                  ),
                ),
              ),
        listData.isNotEmpty ? Details(files: listData) : const SizedBox(),
      ],
    );
  }

  Widget filePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black.withOpacity(.1),
          width: 700,
          height: 50,
          child: Card(
            child: TextField(
              readOnly: true,
              controller: _textControllerFile,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
              decoration: const InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
            ),
          ),
        ),
        Card(
          elevation: 5,
          child: AbsorbPointer(
            absorbing: _isNotClickAble,
            child: IconButton(
              padding: const EdgeInsets.all(5.0),
              color: Colors.black,
              iconSize: 30,
              onPressed: _pickerFile,
              icon: const Icon(Icons.folder_open),
            ),
          ),
        )
      ],
    );
  }

  void _pickerFile() async {
    _isNotClickAble = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    _isNotClickAble = false;
    if (result == null) {
      return;
    }

    String file = result.files.single.path.toString();

    _textControllerFile.text = file.toString();

    fileExcelPath = _textControllerFile.text;
    try {
      var bytes = File(fileExcelPath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      listData = [];
      for (var row in excel.tables[excel.tables.keys.first]!.rows) {
        listData.add(row.map((e) => e!.value.toString()).toList());
      }

      listData.insert(0,
          List.generate(listData[0].length, (index) => "ستون: ${index + 1}"));
    } catch (e) {
      dialog();
    }
    setState(() {});
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
              "تعداد ستون های تمامی سطر ها برابر نیست",
              style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
            ),
            Text(
              fileExcelPath,
              style: const TextStyle(fontFamily: 'bnazanin', fontSize: 20),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _textControllerFile.clear();
              fileExcelPath = '';
              listData.clear();
              setState(() {});
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
