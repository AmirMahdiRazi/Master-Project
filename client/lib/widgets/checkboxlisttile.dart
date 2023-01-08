import 'package:client/variable.dart';
import 'package:client/widgets/animatedtextkit.dart';
import 'package:flutter/material.dart';

class DesignedCheckboxListTile extends StatefulWidget {
  DesignedCheckboxListTile(
      {super.key,
      required this.text,
      required this.function,
      required this.subTitle});
  final String text;
  final Function function;
  final subTitle;

  @override
  State<DesignedCheckboxListTile> createState() =>
      _DesignedCheckboxListTileState();
}

class _DesignedCheckboxListTileState extends State<DesignedCheckboxListTile> {
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
            widget.function;
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
