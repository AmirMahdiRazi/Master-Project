import 'dart:io';
import 'package:flutter/material.dart';
import 'package:server/classes/base.dart';
import 'package:server/classes/courseandstudent.dart';
import 'package:server/widgets/TextandTextField.dart';
import 'package:server/widgets/button.dart';
import 'package:server/widgets/textkit.dart';
import 'package:shamsi_date/shamsi_date.dart';

class SelectNumberMeeting extends StatefulWidget {
  const SelectNumberMeeting({super.key, required this.def, required this.data});
  final List<String> data;
  final Function def;

  @override
  State<SelectNumberMeeting> createState() => _SelectNumberMeetingState();
}

class _SelectNumberMeetingState extends State<SelectNumberMeeting> {
  final TextEditingController textEditingController = TextEditingController();

  bool _isNotClieckAble = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 400,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('بیشترین مقدار :'),
                  const Text(
                    '32',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                        fontSize: 20),
                  )
                ],
              ),
              TextandTextField(
                  fouce: true,
                  count: 2,
                  textEditingController: textEditingController,
                  def: (value) {
                    setState(() {});
                    if (value.isNotEmpty &&
                        int.parse(value) <= 32 &&
                        int.parse(value) >= 1) {
                      _isNotClieckAble = false;
                    } else {
                      _isNotClieckAble = true;
                    }
                  },
                  txt: "جلسه:"),
            ],
          ),
        ),
        widget.data.isEmpty
            ? const DesignAnimatedTextKit(
                text: "اولین جلسه",
                fontsize: 60,
              )
            : SizedBox(
                width: 600,
                height: 200,
                child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: ((context, index) {
                      List<String> temp = widget.data[index].split(' ');

                      return SizedBox(
                        height: 70,
                        child: Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DesignAnimatedTextKit(
                                  fontsize: 30,
                                  text: "تاریخ: ${temp[2]}",
                                ),
                                DesignAnimatedTextKit(
                                  fontsize: 30,
                                  text: "ساعت: ${temp[1]}",
                                ),
                                DesignAnimatedTextKit(
                                  fontsize: 30,
                                  text: "جلسه: ${temp[0]}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 17,
              child: DesignedAnimatedButton(
                bRadius: 0.0,
                width: 200,
                text: 'قبلی',
                onPress: (() {
                  Base().page = true;
                  widget.def();
                }),
              ),
            ),
            Card(
              elevation: 7,
              child: Visibility(
                visible: !_isNotClieckAble,
                child: DesignedAnimatedButton(
                  bRadius: 0.0,
                  width: 200,
                  text: 'تمام',
                  onPress: (() {
                    Course().numberMeeting = textEditingController.text;
                    Course().readExcel();
                    String filePath =
                        '${Base().path}/Files/${Course().courseName}/${Course().courseName}.txt';
                    File(filePath).exists().then((value) {
                      if (value) {
                        String dataLine = formatString();
                        File(filePath)
                            .writeAsStringSync(dataLine, mode: FileMode.append);
                        setState(() {
                          widget.data.insert(0, dataLine);
                        });
                      } else {
                        widget.data.insert(0,
                            'خطایی رخ داده است .نمی توان در فایل ذخیره کرد.');
                      }
                    });

                    Navigator.pushNamed(context, '/SelectIP');
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatString() {
    DateTime now = DateTime.now();
    Jalali nowJalali = now.toJalali();
    List<dynamic> temp = [
      Course().numberMeeting,
      nowJalali.hour,
      nowJalali.minute,
      nowJalali.second,
      nowJalali.month,
      nowJalali.day,
    ].map((e) => e.toString().padLeft(2, '0')).toList();
    return '${temp[0]} ${temp[1]}:${temp[2]}:${temp[3]} ${nowJalali.year}/${temp[4]}/${temp[5]} \n';
  }
}
