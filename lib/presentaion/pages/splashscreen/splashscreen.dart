// import 'package:flutter/material.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
// import 'package:klik/presentaion/pages/homepage/homepage.dart';
// import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     checkUserLogin(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       // backgroundColor: kwhiteColor,
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   (" assets/headline.png"),
//                   width: media.width * .4,
//                 )
//                 //     .animate(delay: 300.milliseconds)
//                 //     .fadeIn(duration: 300.milliseconds)
//                 //     .scale(curve: Curves.fastLinearToSlowEaseIn),
//                 // kheight,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future<void> checkUserLogin(context) async {
//   final preferences = await SharedPreferences.getInstance();
//   final userLoggedIn = preferences.get(authKey);
//   debugPrint(userLoggedIn.toString());
//   if (userLoggedIn == null || userLoggedIn == false) {
//     await Future.delayed(const Duration(seconds: 6));
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => LoginPage(),
//     ));
//   } else {
//     await Future.delayed(const Duration(seconds: 6));
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => Homepage(),
//     ));
//   }
// }
