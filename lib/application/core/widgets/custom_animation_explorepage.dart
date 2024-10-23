// import 'package:flutter/material.dart';
// import 'package:redacted/redacted.dart';

// class ShoeWidget extends StatelessWidget {
//   const ShoeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 80,
//             width: double.infinity,
//             child: Image.network(
//                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ925rJ2StQ_G3Z11SkP5BDHZE08isHL7MbpA&s'),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Shoe Details',
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Shoe Details description',
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 15),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: CircleAvatar(
//               backgroundColor: Colors.grey[400],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RedactedWidget extends StatelessWidget {
//   const RedactedWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Create an instance of ShoeWidget
//     const shoeWidget = ShoeWidget();

//     return shoeWidget.redacted(
//       context: context,
//       redact: true,
//       configuration: RedactedConfiguration(
//         animationDuration: const Duration(milliseconds: 800), // optional
//       ),
//     );
//   }
// }
