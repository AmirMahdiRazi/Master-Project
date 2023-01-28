import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:server/classes/server.dart';
import 'package:server/page_attendance/attendance_page.dart';
import 'package:server/page_createcourse/createcourse_page.dart';
import 'package:server/pages_serverinit/serverInitializer_page.dart';
import 'package:server/page_selectcourse/selectcourse_page.dart';
import 'package:server/classes/base.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  Base().path = Directory.current.path.replaceAll(RegExp(r'\\'), ('/'));

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
  // @override
  // void initState() {
  //   windowManager.addListener(this);
  //   _init();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   windowManager.removeListener(this);
  //   super.dispose();
  // }

  // void _init() async {
  //   // Add this line to override the default close handler
  //   await windowManager.setPreventClose(true);
  //   setState(() {});
  // }
  // void onWindowClose() async {
  //   bool _isPreventClose = await windowManager.isPreventClose();
  //   if (_isPreventClose) {
  //     showDialog(
  //       context: context,
  //       builder: (_) {
  //         return AlertDialog(
  //           title: Text('Are you sure you want to close this window?'),
  //           actions: [
  //             TextButton(
  //               child: Text('No'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             TextButton(
  //               child: Text('Yes'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 await windowManager.destroy();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
}

void checkDevice() async {
  if (Platform.isWindows) await testWindowFunctions();
}

Future testWindowFunctions() async {
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1400, 800),
    size: Size(1400, 800),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  windowManager.setTitle('سامانه حضور و غیاب دانشجویان دانشگاه');
}
