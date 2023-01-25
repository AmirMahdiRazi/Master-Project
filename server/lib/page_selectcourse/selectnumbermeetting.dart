import 'dart:io';

import 'package:flutter/material.dart';
import 'package:server/classes/base.dart';
import 'package:server/classes/courseandstudent.dart';

import 'package:server/widgets/TextandTextField.dart';
import 'package:server/widgets/button.dart';
import 'package:server/widgets/textkit.dart';

class SelectNumberMeetting extends StatefulWidget {
  const SelectNumberMeetting(
      {super.key, required this.def, required this.data});
  final List<String> data;
  final Function def;

  @override
  State<SelectNumberMeetting> createState() => _SelectNumberMeettingState();
}

class _SelectNumberMeettingState extends State<SelectNumberMeetting> {
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
          child: TextandTextField(
              fouce: true,
              count: 2,
              textEditingController: textEditingController,
              def: (value) {
                setState(() {});
                if (value.isNotEmpty && int.parse(value) <= 32) {
                  _isNotClieckAble = false;
                } else {
                  _isNotClieckAble = true;
                }
              },
              txt: "جلسه:"),
        ),
        widget.data.isEmpty
            ? const DesignAnimatedTextKit(
                text: "اولین جلسه",
                fontsize: 60,
              )
            : SizedBox(
                width: 600,
                height: 350,
                child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        height: 100,
                        child: Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Center(
                            child: DesignAnimatedTextKit(
                              fontsize: 30,
                              text: widget.data[index],
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
                    width: 200,
                    text: 'قبلی',
                    onPress: (() {
                      Base().page = true;
                      widget.def();
                    }))),
            Card(
                elevation: 7,
                child: AbsorbPointer(
                  absorbing: _isNotClieckAble,
                  child: DesignedAnimatedButton(
                      width: 200,
                      text: 'تمام',
                      onPress: (() {
                        Course().numberMeeting = textEditingController.text;
                        Course().readExcel();
                        Navigator.pushNamed(context, '/SelectIP');
                      })),
                )),
          ],
        ),
      ],
    );
    ;
  }
}
