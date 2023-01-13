// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';


// typedef Uint8ListCallback = Function(Uint8List data);
// typedef DynamicCallback = Function(dynamic data);

// class Server {
//   Uint8ListCallback? onData;
//   DynamicCallback? onError;

//   Server(this.onData, this.onError);

//   ServerSocket? server;
//   bool running = false;
//   List<Socket> sockets = [];

//   Future<void> start() async {


  //   runZoned(() async {
  //     server = await ServerSocket.bind("192.168.137.1", 5000);
  //     running = true;
  //     server!.listen(onRequest);
  //     final message = "Server is listening in port 4000";
  //     onData!(Uint8List.fromList(message.codeUnits));
  //   }, onError: onError);
  // }

//   void onRequest(Socket socket) {
//     if (!sockets.contains(socket)) sockets.add(socket);
//     socket.listen((event) {
//       onData!(event);
//     });
//   }

//   Future<void> close() async {
//     await server!.close();
//     server = null;
//     running = false;
//   }

//   void broadcast(String data) {
//     onData!(
//       Uint8List.fromList("Broadcast message : $data".codeUnits),
//     );
//     for (final socket in sockets) {
//       socket.write(data);
//     }
//   }
// }
