// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:client/variable.dart';
import 'package:client/widgets/animatedtextkit.dart';
import 'package:flutter/material.dart';

class DesignedCheckBoxListTile extends StatefulWidget {
  const DesignedCheckBoxListTile(
      {super.key,
      required this.text,
      required this.function,
      required this.subTitle});
  final String text;
  final Function function;
  final subTitle;

  @override
  State<DesignedCheckBoxListTile> createState() =>
      _DesignedCheckBoxListTileState();
}

class _DesignedCheckBoxListTileState extends State<DesignedCheckBoxListTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.red),
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: DesignAnimatedTextKit(
            text: widget.text,
            fontsize: 25,
          ),
          subtitle: widget.subTitle != ''
              ? DesignAnimatedTextKit(
                  text: widget.subTitle,
                  fontsize: 15,
                )
              : null,
          value: isCheck,
          onChanged: ((value) {
            setState(() {
              isCheck = value!;
            });
          }),
          activeColor: Colors.green,
          checkColor: Colors.white,
        ),
      ),
    );
  }
}
