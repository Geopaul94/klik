import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';


class ChatRepo {
  static var client = http.Client();

//Create conversation
  static Future createConversation({required List<String> members}) async {
    try {
      final token = await getUsertoken();
      final body = {"members": members};
      var response = client.post(
          Uri.parse(
              '${Apiurl.baseUrl}${Apiurl.createConversation}'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          });
      return response;
    } catch (e) {
  log('createConversation Error: ${e.toString()}');
    }
  }

//get all conversations
  static Future getAllConversations() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${Apiurl.baseUrl}${Apiurl.getAllConversations}'),
          headers: {'Authorization': 'Bearer $token'});
     log('getAllConversations Error: $response');
      return response;
    } catch (e) {
 log('getAllConversations Error: ${e.toString()}');
    }
  }

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

//get all Messages
  static Future getAllMessages({required String conversationId}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${Apiurl.baseUrl}${Apiurl.getAllMessages}/$conversationId'),
          headers: {'Authorization': 'Bearer $token'});

                print(  'messages 11111111111111111111111111111111111   ${response.toString()} ');
      return response;
    } catch (e) {
     log('getAllMessages Error: ${e.toString()}');
    }
  }
}
