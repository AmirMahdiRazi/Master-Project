import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  try {
    final socket = await Socket.connect("127.0.0.1", 3000);
    print(
        "Client: Connected to: ${socket.remoteAddress.address}:${socket.remotePort}");

    socket.listen(
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print("Client $serverResponse");
      },
      onError: (error) {
        print("Client: $error");
        socket.destroy();
      },
      onDone: () {
        print("Client: Server left.");
        socket.destroy();
      },
    );
    String? userName;
    do {
      print("Enter Username");
      userName = stdin.readLineSync();
    } while (userName == null || userName.isEmpty);
    try {
      socket.isEmpty == null ? print("11111") : print('22222');
      socket.write(userName);
    } catch (e) {
      print("Server shut downed!");
    }
  } catch (e) {
    // TODO: must change
    print("can not find server");
  }
}
