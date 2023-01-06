import 'dart:ffi';

import 'package:client/widgets/animatedbutton.dart';

import 'package:client/widgets/checkboxlisttile.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:client/other_file/variable.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/classes/transfer.dart';

class Info_Page extends StatefulWidget {
  const Info_Page({Key? key}) : super(key: key);

  @override
  State<Info_Page> createState() => _HomePageState();
}

class _HomePageState extends State<Info_Page> with TickerProviderStateMixin {
  bool _isFill = false;
  TextEditingController controllerStdNum = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _stdNumber;
  String result_saveOnDisk = '';
  late final AnimationController _controller;
  @override
  void initState() {
    intallizer();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            child: Lottie.asset(
              'assets/account-box.json',
              fit: BoxFit.fill,
              repeat: false,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: controllerStdNum,
              textDirection: TextDirection.rtl,
              autofocus: true,
              maxLines: 1,
              maxLength: 10,
              textInputAction: TextInputAction.next,
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'شماره دانشجویی'),
              keyboardType: TextInputType.datetime,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  _isFill = controllerStdNum.text.length == 10 ? true : false;
                });
              },
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              children: [
                DesignedAnimatedButton(
                  text: 'بعدی',
                  onPress: () {
                    TransferData().client.stdNumber = controllerStdNum.text;
                    checked();
                    isCheck ? readOnDisk() : null;
                    Future.delayed(Duration(milliseconds: 501), () {
                      Navigator.pushNamed(context, '/first');
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: DesignedCheckboxListTile(
                    text: 'به خاطر بسپار',
                    function: checked,
                    subTitle: result_saveOnDisk,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void checked() {
    isCheck ? saveOnDisk() : removeOnDisk();
    readOnDisk();
    isCheck
        ? result_saveOnDisk = (TransferData().client.stdNumber.isEmpty)
            ? 'برای ذخیره کردن مشکلی پیش آمده است'
            : ''
        : null;
  }

  void intallizer() async {
    _stdNumber = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('stdNumber') ?? '';
    });

    controllerStdNum.text = await _stdNumber;
    TransferData().client.stdNumber = controllerStdNum.text;
    isCheck = TransferData().client.stdNumber.isNotEmpty ? true : false;
    _isFill = controllerStdNum.text.length == 10 ? true : false;
    setState(() {});
  }

  void readOnDisk() async {
    final SharedPreferences prefs = await _prefs;
    TransferData().client.stdNumber = prefs.getString('stdNumber') ?? '';
    setState(
      () {},
    );
  }

  void saveOnDisk() async {
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString('stdNumber', TransferData().client.stdNumber.toString())
        .then((value) {
      controllerStdNum.text = TransferData().client.stdNumber;
    });
  }

  void removeOnDisk() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('stdNumber');
  }
}
