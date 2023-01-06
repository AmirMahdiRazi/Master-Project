import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:client/classes/transfer.dart';
import 'package:client/other_file/variable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool _pause = false;

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;

  String? resultCode;
  String? description;
  bool isConnected = false;
  late final subscription;

  StreamController<bool> streamContoller = StreamController<bool>();

  QRViewController? controller;

  // Map<String, String>? result;

  @override
  void initState() {
    streamContoller.stream.listen((event) async {
      await Future.delayed(Duration(seconds: 10));

      // print('d' * 50);
      // status();
      print('15' * 20);
      TransferData().transferDataWifi();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 10, child: buildResult()),
            Positioned(top: 10, child: buildControlButtons()),
          ],
        ),
      ),
    );
  }

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                          snapshot.data! ? Icons.flash_on : Icons.flash_off);
                    } else {
                      return Container();
                    }
                  }),
            ),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(Icons.switch_camera);
                    } else {
                      return Container();
                    }
                  }),
            ),
            Visibility(
              visible: _pause,
              child: IconButton(
                onPressed: () {
                  controller!.resumeCamera();
                },
                icon: Icon(Icons.play_arrow_outlined),
              ),
            )
          ],
        ),
      );
  Widget buildResult() => Container(
        height: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Lottie.asset('assets/qr-code.json'),
      );
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.cyan,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 15,
          cutOutSize: MediaQuery.of(context).size.width * .8,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.scannedDataStream.listen(
        (barcode) => setState(
          (() {
            if (barcode.code != null && barcode.code!.length >= 0) {
              controller.pauseCamera();
              // WiFiForIoTPlugin.disconnect();
              List<String> data = data_extraction(barcode.code!);
              // ** mahdi-123456789-c0:a8:1:64-3000-r542un
              TransferData().client.ipServer = data[2];
              TransferData().client.port = int.parse(data[3]);
              TransferData().client.code = data[4];
              TransferData().client.stdNumber = '9711126050';
              // streamContoller.sink.add(true);
              WiFiForIoTPlugin.connect(data[0],
                      password: data[1], security: NetworkSecurity.WPA)
                  .then((value) {
                //success to connect Wifi
                if (value.toString() == 'true') {
                  streamContoller.sink.add(true);
                } else {
                  controller.resumeCamera();
                }
              });
            }
          }),
        ),
      );
    });
  }

  void _getAndroidId() async {
    var _androidIdPlugin = AndroidId();
    TransferData().client.ID = (await _androidIdPlugin.getId())!;
  }

  List<String> data_extraction(String data) {
    List<String> list, liIp = [];
    list = data.split('-');
    liIp = list[2].split(':');

    for (int i = 0; i < liIp.length; i++) {
      liIp[i] = int.parse(liIp[i], radix: 16).toString();
    }
    list[2] = '${liIp[0]}.${liIp[1]}.${liIp[2]}.${liIp[3]}';

    return list;
  }

  void status() async {
    showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
          resultCode: resultCode,
          description: description,
        );
      }),
    );

    Future.delayed(
      Duration(seconds: 3),
      () {
        if (TransferData().client.result != null) {
          if (TransferData().client.result!["result"] == '200') {
            Navigator.pushNamed(context, '/');
          } else {
            setState(() {
              resultCode = TransferData().client.result!["result"];
              description = TransferData().client.result!['description'];
            });
            TransferData().client.result = null;
          }
        }
      },
    );
  }
}

class Dialog extends StatefulWidget {
  const Dialog({
    Key? key,
    required this.resultCode,
    required this.description,
  }) : super(key: key);
  final String? resultCode;
  final String? description;

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      if (TransferData().client.result != null &&
          TransferData().client.result!["result"] != '200')
        Future.delayed(Duration(seconds: 5), (() {
          Navigator.of(context).pop();
        }));
      Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TransferData().client.result == null
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
              height: 0,
            ),
      content: TransferData().client.result == null
          ? Text(
              'لطفا صبر کنید',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${widget.resultCode}'),
                Text('${widget.description}'),
              ],
            ),
      actions: TransferData().client.result == null
          ? []
          : [
              ElevatedButton(
                onPressed: () {
                  _pause = true;
                  Navigator.of(context).pop();
                },
                child: Text(
                  'متوجه شدم',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.left,
                ),
              )
            ],
    );
  }
}
