// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class DesginedTable extends StatelessWidget {
  DesginedTable({super.key, required this.files});
  List<List<String>> files;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 33, 228, 7),
            Color.fromARGB(255, 4, 255, 234)
          ])),
          child: SingleChildScrollView(
            child: Table(
              children: files
                  .map((e) => TableRow(
                      children: e
                          .map((e) => Card(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontFamily: "bnazanin",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )),
                              ))
                          .toList()))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
