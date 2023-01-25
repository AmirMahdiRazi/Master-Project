import 'package:flutter/material.dart';
import 'package:server/page_selectcourse/bodycourse.dart';

class SelectCourse extends StatelessWidget {
  const SelectCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("انتخاب درس"),
        centerTitle: true,
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
        backgroundColor: Colors.transparent,
      ),
      body: BodyCourse(),
    );
  }
}
