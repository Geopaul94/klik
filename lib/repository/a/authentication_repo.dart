import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/constants/url_.dart';
import 'package:klik/domain/model/userModel.dart';

class AuthenticationRepo {
  static var client = http.Client();
  Future<Response?> sentOtp(UserModel user) async {
    if (kDebugMode) {
      print(user.emailId);
    }

    var data = {
      "userName": user.userName,
      "phoneNumber": user.phoneNumber,
      "userPassword": user.password,
      "emailId": user.emailId,
    };
    var jsonData = jsonEncode(data);

    try {
      debugPrint("----------------");

      final response = await client
          .post(Uri.parse(baseUrl + signup), body: jsonData, headers: {
        "Content-Type": "application/json",
      });
      print(response.body);
      return response;
    } catch (e) {
      debugPrint('+++++++++');
      debugPrint(e.toString());

      print(e.toString());
      return null;
    }
  }
}
