import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/selectcourse/autocomplite.dart';
import 'package:server/server/base.dart';

class BodyCourse extends StatefulWidget {
  const BodyCourse({super.key});

  @override
  State<BodyCourse> createState() => _BodyCourseState();
}

class _BodyCourseState extends State<BodyCourse> {
  late List<String> courses;
  @override
  void initState() {
    checkFile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        SizedBox(
          height: 450,
          child: AutoComplete(
            files: courses,
          ),
        )
      ]),
    );
  }

  void checkFile() async {
    final dir = Directory('${Base().server.path}/Datas');
    if (dir.existsSync()) {
      courses = dir
          .listSync()
          .toList()
          .map((e) => e.path.replaceFirst('${dir.path}\\', ''))
          .toList();
    } else {
      dialog();
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "درس حدید ثبت کنید.درسی ثبت نشده است.",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'bnazanin', fontSize: 20),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Navigator.pushNamed(context, '/createNewCourse');
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
