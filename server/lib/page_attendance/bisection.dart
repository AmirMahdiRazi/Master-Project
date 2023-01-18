
import 'package:flutter/material.dart';

import 'package:server/page_attendance/qrcode.dart';
import 'package:server/temp.dart';

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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(right: padValue_right, left: padValue_left),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: ListView.builder(
              itemCount: 50,
              itemBuilder: ((context, index) {
                return Card(
                  semanticContainer: true,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            data[index][0],
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(data[index][3]),
                          Text(data[index][1]),
                          Text(data[index][2])
                        ],
                      ),
                    ),
                  ),
                );
              })),
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
