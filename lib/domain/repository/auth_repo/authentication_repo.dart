import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/domain/model/userModel.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

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

  //otp verification signup page
  static Future<Response?> verifyOtp(
    String email,
    String otp,
  ) async {
    var client = http.Client();
    try {
      var data = {'email': email, 'otp': otp};
      var response = await client.post(
        Uri.parse(Apiurl.baseUrl + Apiurl.verifyOtp),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        },
      );

      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    //   var response = await client.post(
    //     Uri.parse('$baseurl$otpurl'),
    //     body: user,
    //   );
    //   debugPrint('statuscode:${response.statusCode}');
    //   debugPrint(response.body);
    //   final responsebody = jsonDecode(response.body);
    //   if (response.statusCode == 200) {
    //     return 'successful';
    //   } else if (responsebody['message'] ==
    //       'Invalid verification code or OTP expired') {
    //     return 'Invalid verification code or OTP expired';
    //   } else if (response.statusCode == 500) {
    //     return 'Internal server error';
    //   } else {
    //     return 'failed';
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    //   log(e.toString());
    //   return 'failed';
  }

  static Future<Response?> userLogin(String email, String password) async {
    try {
      var user = {"email": email, "password": password};

      var response = await client.post(Uri.parse(Apiurl.baseUrl + Apiurl.login),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      debugPrint(response.statusCode.toString());
      if (kDebugMode) {
        print(user);
      }

      debugPrint(response.body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await setUserLoggedin(
          token: responseBody['user']['token'],
          userrole: responseBody['user']['role'],
          userid: responseBody['user']['_id'],
          userEmail: responseBody['user']['email'],
          userName: responseBody['user']['userName'],
          userprofile: responseBody['user']['profilePic'],
        );

        
        return response;
      } else {
        return response;
      }
    } catch (e) {}
    return null;
  }

  static Future<Response?> googleLogin(String email) async {
    try {
    
      final finalEmail = {'email': email};
      var response = await client.post(
          Uri.parse(Apiurl.baseUrl + Apiurl.googleLogin),
          body: jsonEncode(finalEmail),
          headers: {"Content-Type": 'application/json'});
    
      // print(response.body);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // print(responseBody);
        await setUserLoggedin(
          token: responseBody['user']['token'],
          userrole: responseBody['user']['role'],
          userid: responseBody['user']['_id'],
          userEmail: responseBody['user']['email'],
          userName: responseBody['user']['userName'],
          userprofile: responseBody['user']['profilePic'],
        );
      }
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> resetPasswordSentOtp(String email) async {
    try {
      Response? response = await client.get(
        Uri.parse("${Apiurl.baseUrl + Apiurl.forgotPassword}$email"),
      );
      debugPrint("{Apiurl.baseUrl + Apiurl.forgotPassword}$email");

      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }




  static Future<Response?> verifyOtpPasswordReset(
      String email, String otp) async {
    try {
      var response = await client.get(Uri.parse(
          '${Apiurl.baseUrl + Apiurl.verifyOtpReset}$email&otp=$otp'));
      debugPrint(response.body);
      debugPrint(
          '${Apiurl.baseUrl + Apiurl.verifyOtpReset}$email&otp=$otp');
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> updatePassword(String email, String password) async {
    try {
      var user = {'email': email, 'password': password};
      var response = await client.patch(
          Uri.parse(Apiurl.baseUrl + Apiurl.updatePassword),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      return null;
    }
  }

}
