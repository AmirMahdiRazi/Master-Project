import 'package:flutter/material.dart';
import 'package:server/page_initalapp/body.dart';

class InitalApp extends StatelessWidget {
  const InitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "درس جدید",
          style: TextStyle(fontFamily: "bnazanin", fontSize: 30),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF72326a),
                Color.fromARGB(255, 68, 0, 170),
              ],
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 59, 1, 134),
      body: Body(),
    );
  }
}
