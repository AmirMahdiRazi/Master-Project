import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/page_attendance/attendance_page.dart';
import 'package:server/page_createcourse/createcourse.dart';
import 'package:server/selectcourse/selectcourse.dart';

import 'package:server/server/base.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  Base server = Base();

  server.server.path = Directory.current.path.replaceAll(RegExp(r'\\'), ('/'));

  runApp(const MyApp());
  checkDevice();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ُServer دانشگاه سمنان',
      theme: ThemeData(
        fontFamily: 'bnazanin',
      ),
      initialRoute: '/selcetCourse',
      routes: {
        '/selcetCourse': (context) => const SelectCourse(),
        '/createCourse': (context) => const CreateCourse(),
      },
    );
  }
}

void checkDevice() async {
  if (Platform.isWindows) await testWindowFunctions();
}

Future testWindowFunctions() async {
  DesktopWindow.setWindowSize(const Size(1400, 950));
  DesktopWindow.setMinWindowSize(const Size(1400, 950));
}
