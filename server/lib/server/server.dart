import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/constrant.dart';

class Server {
  late String ip, user, pass, code;
  late int port;
  late String path;
  ServerSocket? _serverSocket;
  bool running = false;
  List<String> logs = [];
  Status connection = Status.wifi;
  List<Socket> _clients = [];

  void startOrStop() async {
    if (running) {
      _stop();
    } else {
      _start();
    }
  }

  Future<void> _start() async {
    await runZoned(() async {
      _serverSocket = await ServerSocket.bind(ip, port);
      running = true;

      logs.add("Server is running on : $ip:$port");
      _serverSocket!.listen((Socket event) {
        handleConnection(event);
      });
    });
  }

  void _stop() {
    _serverSocket!.close();
    _serverSocket = null;
    running = false;
  }

  void handleConnection(Socket client) {
    logs.add(
        "Client ${client.remoteAddress.address}:${client.remotePort} Connected");

    client.listen(
      (Uint8List data) {
        final message = String.fromCharCodes(data);
        for (final c in _clients) {
          c.write("Server: $message joined the party!");
        }
        _clients.add(client);
        client.write('{"result": "200", "description": "Successfully"}');
        logs.add(message);
      },
      onError: (error) {
        logs.add(error);
        client.close();
      },
      onDone: () {
        _clients.remove(client);
        logs.add("Server: Client left.");
        client.close();
      },
    );
  }

  void ipConvert() {
    List temp = ip.split(".").map((e) {
      return int.parse(e).toRadixString(16);
    }).toList();
    ip = "${temp[0]}.${temp[1]}.${temp[2]}.${temp[3]}";
  }

  Future<Status> checkWifi() async {
    if (connection == Status.wifi) {
      connection = Status.hotspot;
      return connection;
    } else {
      connection = Status.wifi;
      try {
        await NetworkInfo().getWifiName();
      } catch (e) {}
      return connection;
    }
  }

  // String path() {
  //   return directory.path.replaceAll(r'\\', "/");
  // }

  void getUnusedPort(String address) async {
    int portUnused = await ServerSocket.bind(address, 0).then((socket) {
      var portUnused = socket.port;
      socket.close();
      return portUnused;
    });
    port = portUnused;
  }
}
