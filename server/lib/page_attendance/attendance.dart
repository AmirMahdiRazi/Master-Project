// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';
// import 'package:animated_toggle_switch/animated_toggle_switch.dart';

// import '../animation/toggle.dart';
// import 'bisection.dart';

// class Attend extends StatelessWidget {
//   const Attend({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.amber,
//           surfaceTintColor: Colors.blue,
//           actions: [
//             Toggle(),
//             SizedBox(
//               width: 5,
//             )
//           ],
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(30.0),
//               ),
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF72326a),
//                   Color.fromARGB(255, 68, 0, 170),
//                 ],
//               ),
//             ),
//           ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(30.0),
//             ),
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 103, 3, 233),
//         body: Bisection());
//   }
// }
