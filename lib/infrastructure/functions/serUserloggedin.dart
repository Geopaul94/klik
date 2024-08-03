
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUserLoggedin(
    {required String token,
    required String userid,
    required String userrole,
    required String userEmail,
    required String userName,
    required String userprofile}) async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.setBool(authKey, true);
  await sharedprefs.setString(tokenKey, token);
  await sharedprefs.setString(userIdKey, userid);
  await sharedprefs.setString(userRolekey, userrole);
  await sharedprefs.setString(userEmailkey, userEmail);
  await sharedprefs.setString(userNamekey, userName);
  await sharedprefs.setString(userProfilePickey, userprofile);
}








//google login
Future<UserCredential?> siginWithGoogle() async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (kDebugMode) {
      // print(userCredential.user?.email);
    }
    log(userCredential.toString());
    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}

//fire base logout
final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<void> googleSignOut() async {
  await _googleSignIn.signOut();
  log("User signed out");
}
