import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:klik/presentaion/pages/bottomnavBAr/bottomNavBar.dart';
import 'package:klik/presentaion/pages/test_pages/testpage.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
      checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 45,
              ),
              Container(
                height: 200,
                width: 251,
                child: Image.asset(
                  ("assets/headline.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          CustomeLinearcolor(text: "Share Moments",fontSize: 20,gradientColors: [green,blue],)
      
        ],
      ),
    );
  }
}

Future<void> checkUserLogin(context) async {
  final preferences = await SharedPreferences.getInstance();
  final userLoggedIn = preferences.get(authKey);
  debugPrint(userLoggedIn.toString());
  if (userLoggedIn == null || userLoggedIn == false) {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  } else {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomNavBar(),
    ));
  }
}
