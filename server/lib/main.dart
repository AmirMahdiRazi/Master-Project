import 'package:flutter/material.dart';
import 'package:server/page_attendance/attendance.dart';
import 'package:server/pages_serverinit/serverInitializer.dart';
import 'package:server/server/server.dart';
import 'package:server/server/server.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() async {
  Server server = Server();

  runApp(const MyApp());
  // final info = NetworkInfo();

  // var wifiName = await info.getWifiName(); // "FooNetwork"
  // var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
  // var wifiIP = await info.getWifiIP(); // 192.168.1.43
  // print('4444444  $wifiName');
  // var wifiIPv6 =
  //     await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  // var wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
  // var wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
  // var wifiGateway = await info.getWifiGatewayIP();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ُServer دانشگاه سمنان',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => ServerInit(),
        '/first': (context) => Container(),
        '/second': (context) => Container(),
      },
    );
  }
}
