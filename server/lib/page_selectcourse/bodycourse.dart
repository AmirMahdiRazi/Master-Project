// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:server/classes/courseandstudent.dart';

import 'package:server/classes/base.dart';
import 'package:server/page_selectcourse/selectcourse.dart';
import 'package:server/page_selectcourse/selectnumbermeetting.dart';
import 'package:server/widgets/button.dart';
import 'package:window_manager/window_manager.dart';

class BodyCourse extends StatefulWidget {
  const BodyCourse({super.key});

  @override
  State<BodyCourse> createState() => _BodyCourseState();
}

class _BodyCourseState extends State<BodyCourse> with WindowListener {
  late List<String> courses;
  bool _page = true;
  bool lastState = false;
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    checkFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 800,
                height: 550,
                child: Card(
                  elevation: 7,
                  child: Base().page
                      ? SelectCourse(
                          def: () {
                            setState(() {});
                            Base().readData(
                                "${Course().courseName}/${Course().courseName}.txt");
                          },
                          files: courses,
                          page: _page,
                        )
                      : SelectNumberMeetting(
                          def: () {
                            setState(() {});
                          },
                          data: Base().data,
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: DesignedAnimatedButton(
                width: 300,
                text: 'ایجاد درس جدید',
                onPress: () async {
                  Navigator.pushNamed(context, '/createCourse');
                }),
          ),
        ],
      ),
    );
  }

// ??

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (lastState != true && _isPreventClose) {
      lastState = true;
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
                  lastState = false;
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
  void checkFile() async {
    courses = [];
    final dir = Directory('${Base().path}/Files');

    if (dir.existsSync()) {
      List<String> li1 = dir.listSync().map((e) => e.path).toList();
      for (var _ in li1) {
        String temp = _.replaceFirst('${dir.path}\\', '');

        List _listFile = Directory(_)
            .listSync()
            .toList()
            .map((e) => e.path.replaceFirst('$_\\', ''))
            .toList();

        if (_listFile.contains('$temp.txt') &&
            _listFile.contains('$temp.xlsx')) {
          courses.add(_.replaceFirst('${dir.path}\\', ''));
        }
      }
    } else {
      courses = [];
    }
    if (courses.isEmpty) {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      dialog();
    }
  }

  Future dialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "خطا",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 25, color: Colors.red.shade300),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "درس جدید ثبت کنید.درسی ثبت نشده است.",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.popAndPushNamed(context, '/createCourse');
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text(
                "باشه",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
