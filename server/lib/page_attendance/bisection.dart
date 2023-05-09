import 'package:flutter/material.dart';
import 'package:server/classes/courseandstudent.dart';

import 'package:server/page_attendance/qrcode.dart';

class Bisection extends StatefulWidget {
  const Bisection({super.key});

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  int index = 0;
  double padValue_right = 300, padValue_left = 0;
  late String code;
  int time = 0;
  @override
  void initState() {
    Course().def = listPresentStudent;
    super.initState();
  }

  void listPresentStudent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(right: padValue_right, left: padValue_left),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: ListView.builder(
            itemCount: Course().studentsPresent.length,
            itemBuilder: ((context, index) {
              return Card(
                semanticContainer: true,
                margin: const EdgeInsets.all(10),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 9, 161, 167),
                      Color.fromARGB(255, 4, 167, 53)
                    ], stops: [
                      0,
                      .9
                    ]),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        Course().studentsPresent[index].index,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    title: Text(
                      '${Course().studentsPresent[index].fName} ${Course().studentsPresent[index].lName}',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        children: [
                          Text(
                            Course().studentsPresent[index].stdNumber,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            Course().studentsPresent[index].time!,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            Course().studentsPresent[index].day!,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            Course().studentsPresent[index].date!,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        AnimatedPositioned(
          top: index == 0
              ? 0
              : index == 1
                  ? MediaQuery.of(context).size.height - 358
                  : index == 2
                      ? MediaQuery.of(context).size.height - 358
                      : 0,
          right: index == 0
              ? 0
              : index == 1
                  ? 0
                  : index == 2
                      ? MediaQuery.of(context).size.width - 300
                      : MediaQuery.of(context).size.width - 300,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              if (index == 3) {
                index = -1;
              }

              setState(() {
                if (index == -1 || index == 0) {
                  padValue_right = 300;
                  padValue_left = 0;
                } else {
                  padValue_right = 0;
                  padValue_left = 300;
                }
                index++;
              });
            },
            child: QRGenerator(size: 300),
          ),
        ),
      ],
    );
  }
}
