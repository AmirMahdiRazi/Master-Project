import 'package:flutter/material.dart';

class DesignedTextField extends StatefulWidget {
  DesignedTextField(
      {super.key,
      required this.name,
      required this.help,
      required this.textEditingController,
      required this.onChange,
      this.icon,
      this.pass = null});
  String name, help;
  bool? pass;
  TextEditingController textEditingController;
  VoidCallback onChange;
  IconData? icon;
  @override
  State<DesignedTextField> createState() => _DesignedTextFieldState();
}

class _DesignedTextFieldState extends State<DesignedTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.name,
          style: const TextStyle(
              fontFamily: 'bnazanin',
              fontWeight: FontWeight.w900,
              fontSize: 20),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          height: 90,
          width: 500,
          child: TextFormField(
              style: const TextStyle(fontSize: 25),
              obscureText: widget.pass ?? false,
              textAlign: TextAlign.center,
              controller: widget.textEditingController,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                helperText: widget.help,
                suffixIcon: widget.pass != null
                    ? widget.pass!
                        ? IconButton(
                            splashRadius: 1,
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {});
                              if (widget.pass != null) {
                                widget.pass = false;
                              }
                            },
                          )
                        : IconButton(
                            splashRadius: 1,
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {});
                              if (widget.pass != null) {
                                widget.pass = true;
                              }
                            })
                    : Icon(widget.icon),
                hintTextDirection: TextDirection.rtl,
                labelStyle:
                    const TextStyle(textBaseline: TextBaseline.ideographic),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 82, 80, 80), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 255, 34), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
              onChanged: (value) {
                widget.onChange.call();
              }),
        ),
      ],
    );
  }
}
