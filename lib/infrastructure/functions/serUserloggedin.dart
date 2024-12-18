import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/postmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

String currentuserId='';

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

  print('shared preference gerUserId');

   currentuserId = userId.toString();
  print('currentuserId   $currentuserId');
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

String formatDate(DateTime? date) {
  if (date == null) return 'Unknown date';
  return DateFormat('dd MMMM yyyy').format(date.toLocal());
}

List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<void> pickImage(ValueNotifier<String> imageNotifier) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    imageNotifier.value = pickedFile.path;
  }
}
