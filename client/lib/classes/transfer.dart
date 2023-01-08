import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

import 'client_class.dart';

class TransferData {
  static final TransferData _client = TransferData._internal();
  factory TransferData() {
    return _client;
  }
  TransferData._internal();

  Client client = Client();

  void transferDataWifi() async {
    try {
      print('${client.ipServer}, ${client.port}');
      final socket = await Socket.connect(client.ipServer, client.port,
          timeout: Duration(seconds: 3));

      print('44444');
      client.logs.add(
          "Connected to: ${socket.remoteAddress.address}:${socket.remotePort}");

      socket.listen(
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);
          client.logs.add("Response: $serverResponse");
          if (serverResponse.contains('{')) {
            var res = json.decode(serverResponse);
            client.logs.add(
                "Result = ${res["result"]} || discription = ${res["description"]}");
            client.result = {
              'result': res["result"],
              "description": res["description"]
            };
            if (client.result!["result"] == '200') {
              socket.close();
              PluginWifiConnect.disconnect();
            }
          }
        },
        onError: (error) {
          client.logs.add("Client: $error");
          socket.destroy();
        },
        onDone: () {
          client.logs.add("Client: Server left.");
          socket.destroy();
        },
      );

      socket.write(client.combine_data());
      socket.close();
      client.result = null;
    } catch (e) {
      client.result = {'result': '500', 'description': 'سرور در دسترس نیست'};

      client.logs.add("can not find server");
    }
  }
}
