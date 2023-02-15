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

  late Stream stream;

  void transferDataWifi() async {
    try {
      final socket = await Socket.connect(client.ipServer, client.port,
          timeout: const Duration(seconds: 3));

      client.logs.add(
          "Connected to: ${socket.remoteAddress.address}:${socket.remotePort}");

      socket.listen(
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);
          client.logs.add("Response: $serverResponse");
          if (serverResponse.contains('{')) {
            var res = json.decode(serverResponse);
            client.logs.add("Result = ${res["result"]}");
            client.result = {
              'result': res["result"],
            };
            stream;

            socket.close();
            PluginWifiConnect.disconnect();
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
      Future.delayed(Duration(seconds: 7), () {
        socket.close();
        client.result = null;
      });
    } catch (e) {
      client.result = {'result': 'Server Offline'};
      stream;
      client.logs.add("can not find server");
    }
  }
}
