// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:server/classes/base.dart';
import 'package:server/classes/courseandstudent.dart';
import 'package:server/widgets/button.dart';

class SelectCourse extends StatelessWidget {
  SelectCourse(
      {super.key, required this.files, required this.page, required this.def});
  final List<String> files;
  bool page;
  Function def;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: DesignedAnimatedButton(
            width: 800,
            height: 90,
            onPress: () {
              Course().courseName = files[index];
              Base().page = false;
              def();
            },
            text: files[index],
          ),
        );
      }),
    );
  }
}
