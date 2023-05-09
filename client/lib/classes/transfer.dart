import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:client/classes/encrypt.dart';
import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

import 'client.dart';

class TransferData {
  static final TransferData _client = TransferData._internal();
  factory TransferData() {
    return _client;
  }
  TransferData._internal();

  Client client = Client();

  late Function responsServer;
  Encrypt encrypt = Encrypt();

  void transferDataWifi() async {
    try {
      final socket = await Socket.connect(client.ipServer, client.port,
          timeout: const Duration(seconds: 3));
      socket.listen(
        (Uint8List data) {
          final encryptResponse = String.fromCharCodes(data);
          final serverResponse = encrypt.decrypt(encryptResponse);
          if (serverResponse.contains('{')) {
            var res = json.decode(serverResponse);
            client.result = {
              'result': res["result"],
            };
            responsServer();
            socket.close();
            PluginWifiConnect.disconnect();
          }
        },
        onError: (error) {
          socket.destroy();
        },
        onDone: () {
          socket.destroy();
        },
      );
      String data = encrypt.encrypt(client.combineData());
      socket.write(data);
    } catch (e) {
      client.result = {'result': '700'};
      responsServer();
      PluginWifiConnect.disconnect();
    }
  }
}
