import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/page_attendance/attendance_page.dart';
import 'package:server/page_initalapp/intialapp_page.dart';

import 'package:server/pages_serverinit/serverInitializer_page.dart';
import 'package:server/server/base.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  Base server = Base();

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
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitalApp(),
        '/first': (context) => const Attend(),
      },
    );
  }
}

void checkDevice() async {
  if (Platform.isWindows) await testWindowFunctions();
}

Future testWindowFunctions() async {
  await DesktopWindow.setFullScreen(true);
  await DesktopWindow.setMinWindowSize(const Size(1000, 800));
}
