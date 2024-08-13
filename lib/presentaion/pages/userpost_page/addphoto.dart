// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Addphoto_container extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final Color darkGreyMain = Colors.grey[850]!;

//     return Container(
//       height: size.height * 0.35,
//       color: darkGreyMain,
//       width: size.width * 0.9,
//       child: Stack(
//         children: [
//           Center(
//             child: Image.asset(
//               'assets/otpsent.png', // Replace with your image path
//               fit: BoxFit.contain,
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: SizedBox(
//               height: 50, // Adjust the size of the Lottie animation as needed
//               width: 50,
//               child: Lottie.asset(
//                 'assets/animations/camera_klik.json',     fit: BoxFit.contain,// Replace with your Lottie file path
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:lottie/lottie.dart';

Widget addPhotoContainer(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  final Color darkGreyMain = Colors.grey[850]!;

  return Container(
    height: size.height * 0.35,
    color: darkGreyMain,
    width: size.width,
    child: Stack(
      children: [
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.photo,
                color: lightgrey,
                size: 50,
              ),
          h10,
              Text(
                'Add Image....',
                style: TextStyle(fontWeight: FontWeight.w600, color: grey),
              ),
            h10, 
            ],
          ),
        ),
        Positioned(
          bottom: 7,
          right: 7,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Lottie.asset(
              'assets/animations/camera_klik.json',
            ),
          ),
        ),
      ],
    ),
  );
}
