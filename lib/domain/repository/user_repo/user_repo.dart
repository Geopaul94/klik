import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class UserRepo {
  static var client = http.Client();

  //Fetch loggedIn user posts
  static Future fetchUserPosts({String? userId}) async {
    try {
      final loggineduserId = await getUserId();

      if (kDebugMode) {
        print(loggineduserId);
      }
      var response = await client.get(Uri.parse(
          "${Apiurl.baseUrl}${Apiurl.getPostByUserId}/$loggineduserId"));
      if (kDebugMode) {
        print("${Apiurl.baseUrl}${Apiurl.getPostByUserId}/$loggineduserId");
      }
      return response;
    } catch (e) {
         log('Error in fetchUserPosts: ${e.toString()}');
    }
  }

  //Fetch loggedIn user details

  static Future<Response?> fetchLoggedInUserDetails() async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse("${Apiurl.baseUrl}${Apiurl.logginedUser}"),
          headers: {"Authorization": "Bearer $token"});

      return response;
    } catch (e) {
         log('Error in fetchLoggedInUserDetails: ${e.toString()}');
      return null;
    }
  }


  //fetch followers

  static Future fetchFollowers() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getFollowers}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
         log('Error in fetchFollowers: ${e.toString()}');
    }
  }

  //fetch following

  static Future fetchFollowing() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getFollowing}'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
         log('Error in fetchFollowing: ${e.toString()}');
    }
  }

  static Future<http.Response> editProfile({
    required String image,
    required String name,
    required String bio,
    required String imageUrl,
    required String bgImageUrl,
    required String bgImage,
  }) async {
    try {
      String? cloudinaryImageUrl;
      String? cloudinaryBgImageUrl;

      // Upload images if they are provided
      if (image.isNotEmpty) {
        cloudinaryImageUrl = await PostRepo.uploadImage(image);
      }
      if (bgImage.isNotEmpty) {
        cloudinaryBgImageUrl = await PostRepo.uploadImage(bgImage);
      }

      final token = await getUsertoken();

      // Construct profile details
      final details = {
        "name": name,
        "bio": bio,
        "image": image.isNotEmpty ? cloudinaryImageUrl : imageUrl,
        "backGroundImage":
            bgImage.isNotEmpty ? cloudinaryBgImageUrl : bgImageUrl,
      };

      // Send PUT request
      final response = await http.put(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.editProfile}'),
        body: jsonEncode(details),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      // Check for HTTP status codes
      checkStatusCode(response.statusCode);

      return response;
    } catch (e) {
      log('Error in editProfile: ${e.toString()}');
      throw Exception(
          'Failed to edit profile'); // Ensure a non-null response or throw
    }
  }

// unfollow user
  static Future<Response?> unFollowUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.put(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.unfollowUser}/$followeesId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log('Unfollow User Status Code: ${response.statusCode}');
      log('Unfollow User Response Body ======================: ${response.body}');

      checkStatusCode(response.statusCode);

      return response;
    } catch (e) {
      log('Error in unFollowUser: ${e.toString()}');
      return null;
    }
  }

  // follow user

  static Future<Response?> followUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      final response = await http.post(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.followUser}/$followeesId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log('Follow User Status Code: ${response.statusCode}');
      log('Follow User Response Body: ${response.body}');

      checkStatusCode(response.statusCode);

      return response;
    } catch (e) {
      log('Error in followUser: ${e.toString()}');
      return null;
    }
  }

//suggessions

  static Future<Response?> suggestions() async {
    try {
      final token = await getUsertoken();
      final response = await client.get(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.suggessions}'),
        headers: {'Authorization': 'Bearer $token'},
      );

      checkStatusCode(response.statusCode);
      //  log('Status code: ${response.statusCode}');
      // debugPrint('User suggestions: ${response.body}');

      return response;
    } catch (e) {
      log('Error in suggestions: ${e.toString()}');
      return null;
    }
  }

//get connections
  static Future getConnections({required String userId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getConnections}/$userId'),
          headers: {'Authorization': 'Bearer $token'});


      checkStatusCode(response.statusCode);

      
     log('Status code: ${response.statusCode}');
      return response;
    } catch (e) {
       log('Error in getConnections: ${e.toString()}');
    }
  }



    //get single user
  static Future getSingleUser({required String userid}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${Apiurl.baseUrl}${Apiurl.getSingleUser}/$userid'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
          log('Error in getsingleuser: ${e.toString()}');
    }
  }

// search all users


  static Future searchAllUsers({required String query}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.searchAllUsers}$query'),
          headers: {'Authorization': 'Bearer $token'});

          checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
       log('Error in searchalluser: ${e.toString()}');
    }
  }

  // fetch userpostby id

  static Future fetchUserPostsOther({required String userId}) async {
    try {
      var response = await client
          .get(Uri.parse('${Apiurl.baseUrl}${Apiurl.getPostByUserId}/$userId'));
      if (kDebugMode) {
        print('${Apiurl.baseUrl}${Apiurl.getPostByUserId}/$userId');
      }
      debugPrint(
          "fetch postbyUserId ////////////////////////// ${response.statusCode}");
      log("  fetchUserPostsOther      ${response.body}");

      checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
        log('Error in fetchuserpostothers: ${e.toString()}');
    }
  }













  static void checkStatusCode(int statusCode) {
    if (statusCode == 200) {
      // Success, no action needed
    } else if (statusCode == 404) {
      throw Exception('Resource not found');
    } else if (statusCode == 500) {
      throw Exception('Internal server error');
    } else if (statusCode == 401) {
      throw Exception('Unauthorized access');
    } else if (statusCode == 403) {
      throw Exception('Forbidden access');
    } else {
      throw Exception('Failed with status code $statusCode');
    }
  }
}
