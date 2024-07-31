import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/domain/model/userModel.dart';

class AuthenticationRepo {
//   static var client = http.Client();

//   static Future<String> signupOtp(UserModel user, ) async {

//    var client = http.Client();
//     try {
//       final response = await client.post(
//           Uri.parse(Apiurl.baseUrl + Apiurl.signUp),
//           body: jsonEncode(user),
//           headers: {'Content-Type': 'application/json'});
//       debugPrint('statuscode:${response.statusCode}');
//       debugPrint(response.body);
//       final responseBody = jsonDecode(response.body);
//       print(responseBody);

//   if (response.statusCode == 200) {
//         return 'Successful';
//       } else if (responseBody['message'] == "You already have an account.") {
//         return 'You already have an account';
//       } else if (responseBody['message'] ==
//           "OTP already sent within the last one minute") {
//         return 'OTP already sent within the last one minute';
//       } else if (responseBody['message'] == "The username is already taken.") {
//         return 'The username is already taken.';
//       } else if (response.statusCode == 500) {
//         return 'Internal server Error';
//       } else {
//         return ' failed';
//       }

//     }  catch (e) {
//       debugPrint(e.toString());
//      log(e.toString());
//       return 'failed';
//     }
//   }
// }

  static var client = http.Client();
  Future<Response?> sentOtp(UserModel user) async {
    var data = {
      "userName": user.userName,
      "email": user.emailId,
      "password": user.password,
      "phone": user.phoneNumber
    };
    var jsonData = jsonEncode(data);

    try {
      final response = await client.post(
        Uri.parse(Apiurl.baseUrl + Apiurl.signUp),
        body: jsonData,
        headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },
      );

      return response;
    } catch (e) {
      debugPrint('+++++++++');
      debugPrint(e.toString());
      return null;
    }
  }
}
