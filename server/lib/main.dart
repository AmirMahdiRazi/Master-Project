import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/classes/courseandstudent.dart';
import 'package:server/page_attendance/attendance_page.dart';

import 'package:server/page_createcourse/createcourse_page.dart';
import 'package:server/pages_serverinit/serverInitializer_page.dart';
import 'package:server/page_selectcourse/selectcourse_page.dart';

import 'package:server/classes/base.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  Base().path = Directory.current.path.replaceAll(RegExp(r'\\'), ('/'));
  WidgetsFlutterBinding.ensureInitialized();

  checkDevice();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ُServer دانشگاه سمنان',
      theme: ThemeData(fontFamily: 'bnazanin'),
      initialRoute: '/selcetCourse',
      routes: {
        '/selcetCourse': (context) => const SelectCourse(),
        '/SelectIP': (context) => const ServerInit(),
        '/Attendance': (context) => const Attendance(),
        '/createCourse': (context) => const CreateCourse(),
      },
    );
  }
}

void checkDevice() async {
  if (Platform.isWindows) await testWindowFunctions();
}

Future testWindowFunctions() async {
  await DesktopWindow.setWindowSize(Size(1400, 800));
  await DesktopWindow.setMinWindowSize(Size(1400, 800));
}
