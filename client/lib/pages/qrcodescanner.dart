import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:client/classes/transfer.dart';
import 'package:client/variable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

bool _pause = false;

String? _result;
String? _description;

enum _Status { serverOnline, serverOffline, waited }

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

  QRViewController? controller;
  StreamController<_Status> streamContoller = StreamController<_Status>();
  // Map<String, String>? result;

  @override
  void initState() {
    _getAndroidId();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    streamContoller.close();
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

              PluginWifiConnect.disconnect();

              List<String> data = data_extraction(barcode.code!);

              // ** mahdi-123456789-c0:a8:1:64-3000-r542un 1.100
              // ** reza-123456789-c0:a8:89:1-3000-rz542un 137.1
              TransferData().client.ipServer = data[2];
              TransferData().client.port = int.parse(data[3]);
              TransferData().client.code = data[4];

              PluginWifiConnect.connectToSecureNetwork(data[0], data[1])
                  .then((value) {
                if (value == true) {
                  TransferData().transferDataWifi();
                  status();
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
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return Dialog(
          controller: controller!,
          streamcontroller: streamContoller,
        );
      }),
    );
  }
}

class Dialog extends StatefulWidget {
  Dialog({Key? key, required this.controller, required this.streamcontroller})
      : super(key: key);
  final StreamController<_Status> streamcontroller;
  final QRViewController controller;
  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  void dispose() {
    widget.streamcontroller.close();
    getStream();
    super.dispose();
  }

  Stream<_Status> getStream() async* {
    int i = 0;

    await Future.delayed(Duration(seconds: 5));
    if (TransferData().client.result != null) {
      if (TransferData().client.result!["result"] == '200') {
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
            context, '/second', ((route) => false));
      } else if (TransferData().client.result!["result"] != '200') {
        setState(() {
          _result = TransferData().client.result!["result"];
          _description = TransferData().client.result!["description"];
          TransferData().client.result = null;
        });
        yield _Status.serverOffline;
      } else {
        setState(() {
          _result = 'مشکلی پیش آمده است';
          _description = 'لطفا دوباره تلاش کنید';
        });
        yield _Status.waited;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: getStream(),
        builder: (context, snapshot) {
          return AlertDialog(
            title: _result == null
                ? Center(child: CircularProgressIndicator())
                : null,
            content: _result == null
                ? Text(
                    'لطفا صبر کنید',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${_result}'),
                      Text('${_description}'),
                    ],
                  ),
            actions: _result == null
                ? []
                : [
                    ElevatedButton(
                      onPressed: () {
                        _pause = true;
                        TransferData().client.result = null;
                        widget.controller.resumeCamera();
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
        });
  }
}
