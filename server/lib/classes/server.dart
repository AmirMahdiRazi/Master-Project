import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:server/classes/courseandstudent.dart';
import 'package:server/classes/encrypt.dart';
import 'package:server/constrant.dart';

class Server {
  static final Server _server = Server._internal();

  factory Server() {
    return _server;
  }

  Server._internal();
  Encrypt encrypt = Encrypt();
  late String ip, ssid, pass, code;
  late int port;
  ServerSocket? _serverSocket;
  bool running = false;
  bool _runChecker = true;
  ServerStatuses serverstatus = ServerStatuses.normal;
  StatusConnection connection = StatusConnection.wifi;

  void _checkServer() {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (_runChecker == false) {
        timer.cancel();
      } else {
        try {
          await Socket.connect(
            ip,
            port,
            timeout: const Duration(seconds: 3),
          );
        } catch (e) {
          stopManual();
          serverstatus = ServerStatuses.teminate;
          timer.cancel();
        }
      }
    });
  }

  void startOrStop() async {
    if (running) {
      _stop();
    } else {
      _start();
    }
  }

  Future<void> _start() async {
    await runZoned(() async {
      try {
        _serverSocket = await ServerSocket.bind(ip, port);
        running = true;
        _runChecker = true;
        _checkServer();
        _serverSocket!.listen((Socket event) {
          handleConnection(event);
        });
      } catch (e) {
        // Do noting its meaning keep moving
      }
    });
  }

  void stopManual() {
    _serverSocket = null;
    running = false;
    _runChecker = false;
  }

  void _stop() {
    _serverSocket!.close();
    _serverSocket = null;
    running = false;

    _runChecker = false;
  }

  void handleConnection(Socket client) {
    client.listen(
      (Uint8List data) {
        final encryptedData = String.fromCharCodes(data);
        final message = encrypt.decrypt(encryptedData);
        String result = '';
        
        if (message.split('-').length == 3) {
          List temp = message.split('-');
          String id = temp[0];
          String codeClient = temp[1];
          String studentNumber = temp[2];
          if (codeClient != code) {
            result = '{"result": "100"}'; // ?? Code Expaier
          } else {
            for (int i = 0; i < Course().students.length; i++) {
              if (Course().students[i].stdNumber == studentNumber) {
                if (Course().students[i].statusPresent == '0') {
                  bool exsistId = Course()
                      .studentsPresent
                      .map((e) => e.id!.contains(id))
                      .any((element) => element == true);
                  if (!exsistId || Course().studentsPresent.isEmpty) {
                    if (Course().updateExcel(i, id)) {
                      // !!
                      // !!
                      result =
                          '{"result": "200"}'; // ?? Student is in List students and not present
                    } else {
                      result =
                          '{"result":"500"}'; // ?? Can Not Write on Excel File
                    }
                  } else {
                    int indexPreviousStd = Course()
                        .studentsPresent
                        .map((e) => e.id!.contains(id))
                        .toList()
                        .indexOf(true);
                    result =
                        '{"result": "600-${Course().studentsPresent[indexPreviousStd].stdNumber}"}'; // ?? duplicate ID
                  }
                } else {
                  result =
                      '{"result": "300"}'; // ?? Student is in List students and present
                }
                break;
              }
            }
            if (result.isEmpty) {
              result = '{"result": "400"}'; // ?? Student Number Not Found
            }
          }
          String data = encrypt.encrypt(result);
          client.write(data);
        }
      },
      onError: (error) {
        client.close();
      },
      onDone: () {
        client.close();
      },
    );
  }

  String ipConvert() {
    List temp = ip.split(".").map((e) {
      return int.parse(e).toRadixString(16);
    }).toList();
    return "${temp[0]}.${temp[1]}.${temp[2]}.${temp[3]}";
  }

  Future<StatusConnection> checkWifi() async {
    if (connection == StatusConnection.wifi) {
      connection = StatusConnection.hotspot;
      return connection;
    } else {
      connection = StatusConnection.wifi;
      try {
        await NetworkInfo().getWifiName();
      } catch (e) {}
      return connection;
    }
  }

  void getUnusedPort(String address) async {
    int portUnused = await ServerSocket.bind(address, 0).then((socket) {
      var portUnused = socket.port;
      socket.close();
      return portUnused;
    });
    port = portUnused;
  }
}
