import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'dart:convert';
import 'dart:developer';

class UserRepo {
  static var client = http.Client();


  //Fetch loggedIn user posts
  static Future fetchUserPosts({String? userId})async{



    try {
      final loggineduserId = await getUserId();     
      
       if (kDebugMode) {
        print(loggineduserId);
      }var response =await client.get(Uri.parse("${Apiurl.baseUrl }${Apiurl.getPostByUserId}/$loggineduserId"));
         if (kDebugMode) {
        print("${Apiurl.baseUrl }${Apiurl.getPostByUserId}/$loggineduserId");}
    return response;
    } catch (e) {
      log(e.toString());
    }
  }

    //Fetch loggedIn user details
  static Future <Response ?>fetchLoggedInUserDetails()async{
    try {
      final token =await getUsertoken();
      var response =await client.get(Uri.parse("${Apiurl.baseUrl}${Apiurl.logginedUser}"),
      
      
      
      
      headers:  {"Authorization" :"Bearer $token"});
 return response;   } catch (e) {
      log(e.toString());
return null;    }

  }
  
  static Future fetchFollowers() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getFollowers}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
  
  //fetch followers
  
   static Future fetchFollowing() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getFollowing}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }



  static Future editProfile(
      {required String image,
    required  String name,
     required String bio,
    required  String imageUrl,
    required  String bgImageUrl,
      required String bgImage}) async {
    try {
      dynamic cloudinaryimageUrl;
      dynamic cloudinarybgimageUrl;
      if (image != '') {
        cloudinaryimageUrl = await PostRepo.uploadImage(image);
      }
      if (bgImage != '') {
        cloudinarybgimageUrl = await PostRepo.uploadImage(bgImage);
      }
      final token = await getUsertoken();
      final details = {
        "name": name ,
        "bio": bio ,
        "image": image != '' ? cloudinaryimageUrl : imageUrl,
        "backGroundImage": bgImage != '' ? cloudinarybgimageUrl : bgImageUrl
      };
      var response = await client.put(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.editProfile}'),
          body: jsonEncode(details),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
    // final image
  }

}