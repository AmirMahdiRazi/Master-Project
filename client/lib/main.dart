import 'package:client/backgroundwidget.dart';
import 'package:client/pages/connection.dart';
import 'package:client/pages/info_page.dart';

import 'package:client/pages/success.dart';

import 'package:flutter/material.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const BackgroundWidget(child: Info_Page()),
        '/first': (context) => const ConnectionPage(),
        '/second': (context) => const Success(),
      },
    );
  }
}
