// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:device_information/device_information.dart';

// class Temp extends StatefulWidget {
//   @override
//   _TempState createState() => _TempState();
// }

// class _TempState extends State<Temp> {
//   String _platformVersion = 'Unknown',
//       _imeiNo = "",
//       _modelName = "",
//       _manufacturerName = "",
//       _deviceName = "",
//       _productName = "",
//       _cpuType = "",
//       _hardware = "";
//   var _apiLevel;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     late String platformVersion,
//         imeiNo = '',
//         modelName = '',
//         manufacturer = '',
//         deviceName = '',
//         productName = '',
//         cpuType = '',
//         hardware = '';
//     var apiLevel;
//     // Platform messages may fail,
//     // so we use a try/catch PlatformException.
//     try {
//       platformVersion = await DeviceInformation.platformVersion;
//       imeiNo = await DeviceInformation.deviceIMEINumber;
//       modelName = await DeviceInformation.deviceModel;
//       manufacturer = await DeviceInformation.deviceManufacturer;
//       apiLevel = await DeviceInformation.apiLevel;
//       deviceName = await DeviceInformation.deviceName;
//       productName = await DeviceInformation.productName;
//       cpuType = await DeviceInformation.cpuName;
//       hardware = await DeviceInformation.hardware;
//     } on PlatformException catch (e) {
//       platformVersion = '${e.message}';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = "Running on :$platformVersion";
//       _imeiNo = imeiNo;
//       _modelName = modelName;
//       _manufacturerName = manufacturer;
//       _apiLevel = apiLevel;
//       _deviceName = deviceName;
//       _productName = productName;
//       _cpuType = cpuType;
//       _hardware = hardware;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Device Information Plugin Example app'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 40,
//               ),
//               Text('$_platformVersion\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('IMEI Number: $_imeiNo\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Device Model: $_modelName\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('API Level: $_apiLevel\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Manufacture Name: $_manufacturerName\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Device Name: $_deviceName\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Product Name: $_productName\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('CPU Type: $_cpuType\n'),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Hardware Name: $_hardware\n'),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:client/classes/transfer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  void initState() {
    // WiFiForIoTPlugin.connect('reza', password: '123456789');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // PluginWifiConnect.connectToSecureNetwork('reza', '123456789'
        // WiFiForIoTPlugin.findAndConnect(
        //   'ssid',
        //   password: '123456789',
        //   withInternet: true,
        // );

        // // PluginWifiConnect.connectToSecureNetwork('reza', '123456789')
        // // .then((value) {
        // Future.delayed(Duration(seconds: 10), () {
        //   print('=' * 25);
        //   // print(value.toString());
        //   TransferData().client.ipServer = '192.168.137.1';
        //   TransferData().client.port = 3000;
        //   TransferData().transferDataWifi();
        // });
        // // });

        PluginWifiConnect.connectToSecureNetwork('reza', '123456789')
            .then((value) {
          Future.delayed(Duration(seconds: 10), () {
            print('=' * 25);
            // print(value.toString());
            TransferData().client.ipServer = '192.168.137.1';
            TransferData().client.port = 3000;
            TransferData().transferDataWifi();
          });
        });
      },
      child: Text('press'),
    );
  }
}
