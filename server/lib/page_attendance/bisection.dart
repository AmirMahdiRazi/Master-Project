import 'package:flutter/material.dart';
import 'package:server/classes/courseandstudent.dart';
import 'package:server/constrant.dart';

import 'package:server/page_attendance/qrcode.dart';

class Bisection extends StatefulWidget {
  const Bisection({super.key});

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  int index = 0;
  double padValue_right = 200, padValue_left = 0;
  late String code;
  int time = 0;
  @override
  void initState() {
    Course().def = listPresentStudent;
    super.initState();
  }

  Stream<List<Student>> get listPresentStudent async* {
    yield Course().studentsPresent;
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
          child: StreamBuilder<List<Student>>(
              stream: listPresentStudent,
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: Course().studentsPresent.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        semanticContainer: true,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                Course().studentsPresent[index].index,
                                style: kstyleNumber,
                              ),
                            ),
                            title: Text(
                              '${Course().studentsPresent[index].fName} ${Course().studentsPresent[index].lName}',
                              style: TextStyle(fontSize: 25),
                            ),
                            trailing: FittedBox(
                              fit: BoxFit.contain,
                              child: Row(
                                children: [
                                  Text(
                                    Course().studentsPresent[index].stdNumber,
                                    style: kstyleNumber,
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    Course().studentsPresent[index].time!,
                                    style: kstyleNumber,
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    Course().studentsPresent[index].day!,
                                    style: kstyleNumber,
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    Course().studentsPresent[index].date!,
                                    style: kstyleNumber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
              }),
        ),
        AnimatedPositioned(
          top: index == 0
              ? 0
              : index == 1
                  ? MediaQuery.of(context).size.height - 258
                  : index == 2
                      ? MediaQuery.of(context).size.height - 258
                      : 0,
          right: index == 0
              ? 0
              : index == 1
                  ? 0
                  : index == 2
                      ? MediaQuery.of(context).size.width - 200
                      : MediaQuery.of(context).size.width - 200,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              if (index == 3) {
                index = -1;
              }

              setState(() {
                if (index == -1 || index == 0) {
                  padValue_right = 200;
                  padValue_left = 0;
                } else {
                  padValue_right = 0;
                  padValue_left = 200;
                }
                index++;
              });
            },
            child: QRGenearator(size: 200),
          ),
        ),
      ],
    );
  }
}
