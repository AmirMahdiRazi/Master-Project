import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:client/widgets/animatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_settings/open_settings.dart';

class WifiConnection extends StatelessWidget {
  WifiConnection({super.key});
  bool connected_wifi = false;
  @override
  Widget build(BuildContext context) {
    return Connection();
  }
}

class Connection extends StatelessWidget {
  Connection({super.key});
  String wifiname = 'amir', password = 'amir1234';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  textStyle: TextStyle(fontSize: 20),
                  '.به وای فای با اطلاعات زیر متصل شوید',
                  speed: Duration(milliseconds: 100),
                  textAlign: TextAlign.end,
                  curve: Curves.fastLinearToSlowEaseIn,
                  cursor: '',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        textStyle: TextStyle(fontSize: 20),
                        'WifiName: ',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.justify,
                        curve: Curves.fastLinearToSlowEaseIn,
                        cursor: '',
                      ),
                    ],
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        textStyle: TextStyle(fontSize: 20),
                        '$wifiname',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.justify,
                        curve: Curves.easeInCirc,
                        cursor: '',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          textStyle: TextStyle(fontSize: 20),
                          'Password: ',
                          speed: Duration(milliseconds: 100),
                          textAlign: TextAlign.justify,
                          curve: Curves.fastLinearToSlowEaseIn,
                          cursor: '',
                        ),
                      ],
                    ),
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        textStyle: TextStyle(fontSize: 20),
                        '$password',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.justify,
                        curve: Curves.fastLinearToSlowEaseIn,
                        cursor: '',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DesignedAnimatedButton(
              onPress: () {
                Clipboard.setData(ClipboardData(text: password)).then((value) {
                  final snackBar = SnackBar(
                    content: Text(
                      'کپی شد',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              text: "کپی",
              height: 40,
              width: 75,
              borderRadius: 20,
            ),
            SizedBox(
              height: 150,
            ),
            DesignedAnimatedButton(
              onPress: () {
                // openAppSettings();
                Future.delayed(Duration(milliseconds: 501), () {
                  OpenSettings.openWIFISetting();
                });
              },
              text: "Wifi",
            )
          ],
        ),
      ),
    );
  }
}
