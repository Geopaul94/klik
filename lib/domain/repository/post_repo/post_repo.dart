import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

class PostRepo {
  static var client = http.Client();
  //Add post
  static Future<Response?> addPost(String description, String image) async {
    try {
      final imageUrl = await PostRepo.uploadImage(image);
      final userid = await getUserId();
      final token = await getUsertoken();
      final post = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userid
      };
      var response = await client.post(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.addpostUrl}'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint(response.statusCode.toString());
      return response;
    } catch (e) {
      return null;
    }
  }

  // upload to cloudinary
  static Future uploadImage(imagePath) async {
    String filePath = imagePath;
    File file = File(filePath);
    try {
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/image/upload');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'vlbl4hxd'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();
      // debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        // log(jsonMap['url']);
        return jsonMap['url'];
      }
    } catch (e) {
      log(e.toString());
    }
  }

//   Delete Post
  static Future<Response?> deletePost(String postId) async {
    try {
      final token = await getUsertoken();
      var response = await client.delete(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.deletePost}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      debugPrint(
          'DELETE post API called ++++++++ ${response.statusCode.toString()}');
      checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

//get all usesr post

  static Future<Response?> getAllPosts() async {
    try {
      final token = await getUsertoken();
      final response = await client.get(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.getallPost}'),
        headers: {'Authorization': 'Bearer $token'},
      );

      // log(response.statusCode.toString());
      // debugPrint(response.body);

      checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//get followers post
  static Future<Response?> getFollowersPost(int page) async {
    try {
      final token = await getUsertoken();
      final response = await client.get(
        Uri.parse('${Apiurl.baseUrl}${Apiurl.allFollowingsPost}?page=$page'),
        headers: {'Authorization': 'Bearer $token'},
      );

      //  log('API Call for followerspost: Status Code: ${response.statusCode}');
      //   log('API Response: ${response.body}');
      checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
      log('API Error: $e');
      return null;
    }
  }

  //edit post

  static Future<Response?> editPost(
      {required String description,
      required image,
      required String postId,
      required imageUrl}) async {
    dynamic cloudinaryimageUrl;
    try {
      if (image != '') {
        cloudinaryimageUrl = await PostRepo.uploadImage(image);
      }
      final token = await getUsertoken();
      final post = {
        'imageUrl': image != '' ? cloudinaryimageUrl : imageUrl,
        'description': description,
      };
      var response = await client.put(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.updatePost}/$postId'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
      log(response.statusCode.toString());
      log(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

// get saved posts
  static Future fetchSavedPosts() async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.fetchSavedPost}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//fetch posts by user

  static Future<Response?> fetchpostbyuser() async {
    try {
      final userid = await getUserId();

      final response = await client.get(
          Uri.parse("${Apiurl.baseUrl}${Apiurl.getPostByUserId}/$userid"),
          headers: {'Authorization': 'Bearer $userid'});

      checkStatusCode(response.statusCode);

      // log('Status code of fetchpostby user: ${response.statusCode}');
      // debugPrint('user posts suggestions: ${response.body}');
      return response;
    } catch (e) {
      log("error in fetching userposr ${e.toString()}");
      return null;
    }
  }

//comment post

  static Future commentPost(
      {required String postId,
      required String userName,
      required String content}) async {
    try {
      final userId = await getUserId();
      final token = await getUsertoken();
      final comment = {
        'userId': userId,
        'userName': userName,
        'postId': postId,
        'content': content
      };
      var response = await client.post(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.commentPost}/$postId'),
          body: jsonEncode(comment),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      //  checkStatusCode(response.statusCode);

      log('comment post status code : ${response.statusCode}');
      log(response.body);
      return response;
    } catch (e) {
      log(" add comment  /////        error in add comment on the post ${e.toString()}");
    }
  }

// delete comment

  static Future<Response?> deleteComment({required String commentId}) async {
    try {
      final token = await getUsertoken();
      final response = await client.delete(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.deleteComments}/$commentId'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      checkStatusCode(response.statusCode);

      return response;
    } catch (e) {
      log(" delete comment/////        error in fetching userposr ${e.toString()}");
      return null;
    }
  }

//get all  comments
  static Future getAllCommentPost({required String postId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.getAllComments}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      log('Status code of getallcomments user: ${response.statusCode}');
      //       log('getallcomments: ${response.body}');

      debugPrint(response.statusCode.toString());
      checkStatusCode(response.statusCode);
      return response;
    } catch (e) {
      log(" getallcomments user/////        error in fetching userposr ${e.toString()}");
    }
  }

// post unlike

  static Future<Response?> likePost({required String postId}) async {
  try {
    final token =await getUsertoken();
    final response = await client.patch(
      Uri.parse('${Apiurl.baseUrl}${Apiurl.likePost}/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      log('Like post successful. Status code: ${response.statusCode}');
      log(response.body);
      return response;
    } else {
      checkStatusCode(response.statusCode);
      log('Like post failed. Status code: ${response.statusCode}');
      log(response.body);
      return null;
    }
  } catch (e) {
    log("Error in liking post: ${e.toString()}");
    return null;
  }
}




// post unlike

 static Future<Response?> unlikePost({required String postId}) async {
  try {
    final token = getUsertoken();
    final response = await client.patch(
      Uri.parse('${Apiurl.baseUrl}${Apiurl.unlikePost}/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      log('Unlike post successful. Status code: ${response.statusCode}');
      log(response.body);
      return response;
    } else {
      checkStatusCode(response.statusCode);
      log('Unlike post failed. Status code: ${response.statusCode}');
      log(response.body);
      return null;
    }
  } catch (e) {
    log("Error in unliking post: ${e.toString()}");
    return null;
  }
}
}

void checkStatusCode(int statusCode) {
  if (statusCode == 200) {
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
