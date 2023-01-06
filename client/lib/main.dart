import 'package:client/classes/Transfer.dart';
import 'package:client/pages/connection.dart';
import 'package:client/pages/info_page.dart';
import 'package:client/pages/qrcodescanner.dart';
import 'package:client/pages/success.dart';
import 'package:client/pages/temp.dart';

import 'package:client/pages/wifi_connection.dart';

import 'package:flutter/material.dart';

// import 'package:client/pages/temp.dart';
void main() {
  TransferData client = TransferData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دانشگاه سمنان',
      theme: ThemeData.light(),
      initialRoute: '/second',
      routes: {
        '/': (context) => Info_Page(),
        '/first': (context) => ConnectionPage(),
        '/second': ((context) => name())
      },
    );
  }
}
