import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const Color login_bg = Color.fromARGB(0, 0, 0, 0);
const Color signup_bg = Color.fromARGB(0, 31, 112, 24);

const Color green = Colors.green;
const Color white = Colors.white;
const Color red = Colors.red;
const Color blue = Colors.blue;
const Color purple = Colors.purple;



const double defaultpadding = 16.0;
// const String  header =  "Content-Type": "application/json";
const Duration defaultDuration = Duration(microseconds: 300);

const Gradient gradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 232, 218, 218),
    Color.fromARGB(255, 232, 218, 218),
    // Color.fromARGB(255, 223, 187, 187),
  ],
);

const TextStyle colorizeTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Horizon',
);


//auth key
const authKey = 'UserLoggedIn';

//token key sharedpreference
const tokenKey = 'userToken';

//userid key sharedpreference
const userIdKey = 'userId';

//userRole key sharedpreference
const userRolekey = 'userRole';

//userEmail key sharedpreference
const userEmailkey = 'userEmail';

//userName key sharedpreference
const userNamekey = 'userName';

//userProfilepic key sharedpreference
const userProfilePickey = 'userProfilePic';