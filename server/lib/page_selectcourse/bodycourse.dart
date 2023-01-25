import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:server/classes/courseandstudent.dart';

import 'package:server/classes/base.dart';
import 'package:server/page_selectcourse/selectcourse.dart';
import 'package:server/page_selectcourse/selectnumbermeetting.dart';
import 'package:server/widgets/button.dart';

class BodyCourse extends StatefulWidget {
  const BodyCourse({super.key});

  @override
  State<BodyCourse> createState() => _BodyCourseState();
}

class _BodyCourseState extends State<BodyCourse> {
  late List<String> courses;
  bool _page = true;
  @override
  void initState() {
    checkFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 800,
            height: 500,
            child: Card(
              elevation: 7,
              child: Base().page
                  ? SelectCourse(
                      def: () {
                        setState(() {});
                        Base().setData(
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
          DesignedAnimatedButton(
              width: 300,
              text: 'ایجاد درس جدید',
              onPress: () async {
                Navigator.pushNamed(context, '/createCourse');
              })
        ],
      ),
    );
  }

  void checkFile() async {
    courses = [];
    final dir = Directory('${Base().path}/Datas');

    if (dir.existsSync()) {
      List<String> li1 = dir.listSync().map((e) => e.path).toList();
      for (var _ in li1) {
        String temp = _.replaceFirst('${dir.path}\\', '');
        print(temp);
        List _listFile = Directory(_)
            .listSync()
            .toList()
            .map((e) => e.path.replaceFirst(_ + '\\', ''))
            .toList();

        if (_listFile.contains(temp + '.txt') &&
            _listFile.contains(temp + '.xlsx')) {
          courses.add(_.replaceFirst('${dir.path}\\', ''));
        }
      }
    } else {
      courses = [];
      await Future.delayed(Duration(milliseconds: 50));
    }
    if (courses.isEmpty) {
      await Future.delayed(
        Duration(milliseconds: 50),
      );
      dialog();
    }
  }

  Future dialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "خطا",
          textAlign: TextAlign.right,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "درس حدید ثبت کنید.درسی ثبت نشده است.",
              textDirection: TextDirection.rtl,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
