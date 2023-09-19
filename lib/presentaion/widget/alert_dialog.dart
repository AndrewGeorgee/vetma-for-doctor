// // ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:vetma_final_project/core/resources/icon_broken.dart';

// import '../../core/resources/assets_manger.dart';

// Future<void> showMyDialog(context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         titlePadding: const EdgeInsets.symmetric(vertical: double.minPositive),
//         title: Row(
//           //crossAxisAlignment: CrossAxisAlignment.center,
//           //  mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 IconBroken.Arrow___Left_Circle,
//               ),
//             ),
//             const SizedBox(width: 35),
//             const Text('Chosse The Pet'),
//           ],
//           //!
//         ),
//         content: Row(
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 icon: Image.asset(
//                   AssetsManager.cat,
//                 ),
//               ),
//             ),
//             Container(
//               width: 80,
//               height: 80,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 icon: Image.asset(
//                   AssetsManager.cat,
//                 ),
//               ),
//             ),
//             Container(
//               width: 80,
//               height: 80,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 icon: Image.asset(
//                   AssetsManager.cat,
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
