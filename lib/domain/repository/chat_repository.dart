import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';


class ChatRepo {
  static var client = http.Client();

//Create conversation
  // static Future createConversation({required List<String> members}) async {
  //   try {
  //     final token = await getUsertoken();
  //     final body = {"members": members};
  //     var response = client.post(
  //         Uri.parse(
  //             '${Apiurl.baseUrl}${Apiurl.createConversation}'),
  //         body: jsonEncode(body),
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': "application/json"
  //         });
  //     return response;
  //   } catch (e) {
  // log('createConversation Error: ${e.toString()}');
  //   }
  // }



static Future<http.Response?> createConversation({required List<String> members}) async {
  try {
    final token = await getUsertoken();
    final body = {"members": members};
    
    // Await the post request
    var response = await client.post(
      Uri.parse('${Apiurl.baseUrl}${Apiurl.createConversation}'),
      body: jsonEncode(body),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      },
    );

    // Check if the response is successful
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;  // Return the valid response
    } else {
      log('createConversation status code: ${response.statusCode}');
      log('createConversation response body: ${response.body}');
      return response;  // Or handle this in some other way (e.g., throw error)
    }
  } catch (e) {
    log('createConversation Error: ${e.toString()}');
    return null;  // Return null or handle the error accordingly
  }
}

























//get all conversations
//   static Future getAllConversations() async {
//     try {
//       final token = await getUsertoken();
//       var response = client.get(
//           Uri.parse(
//               '${Apiurl.baseUrl}${Apiurl.getAllConversations}'),
//           headers: {'Authorization': 'Bearer $token'});

   
//      log('getAllConversations Error: $response');
//       return response;
//     } catch (e) {
//  log('getAllConversations Error: ${e.toString()}');
//     }
//   }




// get all conversations
static Future<Response?> getAllConversations() async {
  try {
    final token = await getUsertoken();
    // Await the response from the API call
    final response = await client.get(
      Uri.parse('${Apiurl.baseUrl}${Apiurl.getAllConversations}'),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Log the status code and response body
    log('Status code  getAllConversations: ${response.statusCode}');
  //  log('Response body: ${response.body}');

    return response;
  } catch (e) {
    log('getAllConversations Error: ${e.toString()}');
    return null; // Return null in case of an error
  }
}



















//Add message
//   static Future addMessage(
//       {required String recieverId,
//       required String text,
//       required String conversationId,
//       required String senderId}) async {
//     try {
//       final token = await getUsertoken();
//       final body = {
//         "senderId": senderId,
//         "conversationId": conversationId,
//         "text": text,
//         "recieverId": recieverId
//       };
//       var response = client.post(
//           Uri.parse('${Apiurl.baseUrl}${Apiurl.addMessage}'),
//           body: jsonEncode(body),
//           headers: {
//             'Authorization': 'Bearer $token',
//             "Content-Type": 'application/json'
//           });
//       return response;
//     } catch (e) {
//  log('addMessage Error: ${e.toString()}');
//     }
//   }






// static Future<Response?> addMessage({
//   required String recieverId,
//   required String text,
//   required String conversationId,
//   required String senderId,
// }) async {
//   try {
//     final token = await getUsertoken();
//     // Corrected receiverId
//     final body = {
//       "senderId": senderId,
//       "conversationId": conversationId,
//       "text": text,
//       "receiverId": recieverId // Fixed spelling issue here
//     };

//     var response = await client.post(
//       Uri.parse('${Apiurl.baseUrl}${Apiurl.addMessage}'),
//       body: jsonEncode(body),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     log('addMessage Error:  ${response.statusCode}');
//     log('Request Body: $body');
//     log('Response: ${response.body}');
//     return response;
//   } catch (e) {
//     log('addMessage Error: ${e.toString()}');
//     return null;
//   }
// }

 //Add message
  static Future addMessage(
      {required String recieverId,
      required String text,
      required String conversationId,
      required String senderId}) async {
    try {
      final token = await getUsertoken();
      final body = {
        "senderId": senderId,
        "conversationId": conversationId,
        "text": text,
        "recieverId": recieverId
      };
      var response = client.post(
          Uri.parse('${Apiurl.baseUrl}${Apiurl.addMessage}'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": 'application/json'
          });
      return response;
    } catch (e) {
     log('addMessage Error: ${e.toString()}');
    }
  }






















//Add message
  // static Future addMessage(
  //     {required String recieverId,
  //     required String text,
  //     required String conversationId,
  //     required String senderId}) async {
  //   try {
  //     final token = await getUsertoken();
  //     final body = {
  //       "senderId": senderId,
  //       "conversationId": conversationId,
  //       "text": text,
  //       "recieverId": recieverId
  //     };
  //     var response = client.post(
  //         Uri.parse('${Apiurl.baseUrl}${Apiurl.addMessage}'),
  //         body: jsonEncode(body),
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           "Content-Type": 'application/json'
  //         });



  //     return response;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }














//get all Messages
  // static Future getAllMessages({required String conversationId}) async {
  //   try {
  //     final token = await getUsertoken();
  //     var response = client.get(
  //         Uri.parse(
  //             '${Apiurl.baseUrl}${Apiurl.getAllMessages}/$conversationId'),
  //         headers: {'Authorization': 'Bearer $token'});

  //               print(  'messages 11111111111111111111111111111111111   ${response.toString()} ');
  //     return response;
  //   } catch (e) {
  //    log('getAllMessages Error: ${e.toString()}');
  //   }
  // }

// Get all messages

static Future<Response?> getAllMessages({required String conversationId}) async {
  try {
    final token = await getUsertoken();
    
    // Await the API call and ensure it's handled properly
    final response = await client.get(
      Uri.parse('${Apiurl.baseUrl}${Apiurl.getAllMessages}/$conversationId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // Log the entire response to debug the issue



    log('API Response   getAllMessages: ${response.statusCode}');
   //  log('API Response   getAllMessages: ${response.statusCode} - ${response.body}');
    
    return response;
  } catch (e) {
    // Log error details
    log('getAllMessages Error: ${e.toString()}');
    return null; // Return null in case of failure
  }
}





}
