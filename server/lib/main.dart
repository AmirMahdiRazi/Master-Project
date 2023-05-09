import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:server/page_attendance/attendance_page.dart';
import 'package:server/page_createcourse/createcourse_page.dart';
import 'package:server/pages_serverinit/serverInitializer_page.dart';
import 'package:server/page_selectcourse/selectcourse_page.dart';
import 'package:server/classes/base.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  if (Base().path.isEmpty) {
    Base().path = Directory.current.path.replaceAll(RegExp(r'\\'), ('/'));
  }

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  testWindowFunctions();
  runApp(const MyApp());
  checkDevice();
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
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await testWindowFunctions();
  }
}

Future testWindowFunctions() async {
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1000, 800),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  windowManager.setTitle('سامانه حضور و غیاب دانشجویان دانشگاه سمنان');
}
