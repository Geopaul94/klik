import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/url/url_.dart';
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
// get user token

Future<String?> getUsertoken() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final token = sharedpreference.getString(tokenKey);
  return token;
}

//get Userid
Future<String?> getUserId() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userId = sharedpreference.getString(userIdKey);
  return userId;
}

// Clear user session
Future<void> clearUserSession() async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.remove(authKey);
  await sharedprefs.remove(tokenKey);
  await sharedprefs.remove(userIdKey);
  await sharedprefs.remove(userRolekey);
  await sharedprefs.remove(userEmailkey);
  await sharedprefs.remove(userNamekey);
  await sharedprefs.remove(userProfilePickey);
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
      print(userCredential.user?.displayName);
    }
    return userCredential;
  } catch (e) {
    return null;
  }
}

//fire base logout
final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<void> googleSignOut() async {
  await _googleSignIn.signOut();
  log("User signed out");
}

String formatDate(String inputDate) {
  // Define the input format
  DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
  // Define the output format
  DateFormat outputFormat = DateFormat('dd MMM yyyy');

  // Parse the input date string
  DateTime dateTime = inputFormat.parseUtc(inputDate);
  DateTime now = DateTime.now().toUtc();

  // Calculate the difference
  Duration difference = now.difference(dateTime);

  // Check if the date is within one week
  if (difference.inDays < 7) {
    // Check if the date is today
    if (difference.inDays == 0) {
      if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'just now';
      }
    } else {
      return '${difference.inDays} days ago';
    }
  } else {
    return outputFormat.format(dateTime);
  }
  


}


Future<void> pickImage(ValueNotifier<String> imageNotifier) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageNotifier.value = pickedFile.path;
    }
  }
