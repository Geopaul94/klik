// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/conversationModel.dart';
import 'package:klik/domain/model/get_userchatModel.dart';
import 'package:klik/domain/repository/chat_repository.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
part 'fetch_all_conversations_event.dart';
part 'fetch_all_conversations_state.dart';

class FetchAllConversationsBloc
    extends Bloc<FetchAllConversationsEvent, FetchAllConversationsState> {
  // List<GetUserModel> users = [];
  // List<ConversationModel> conversation = [];

  FetchAllConversationsBloc() : super(FetchAllConversationsInitial()) {
    on<FetchAllConversationsEvent>((event, emit) {});
    on<AllConversationsInitialFetchEvent>(allConversationsInitialFetchEvent);
    // on<SearchConversationsEvent>(searchConversationsEvent);
  }

//   FutureOr<void> allConversationsInitialFetchEvent(
//       AllConversationsInitialFetchEvent event,
//       Emitter<FetchAllConversationsState> emit) async {
//     emit(FetchAllConversationsLoadingState());
//     final userid = await getUserId();
//     final Response response = await ChatRepo.getAllConversations();
//     debugPrint('conversation fetch statuscode is-${response.statusCode}');
//     debugPrint('fetchall conversations body is -${response.body}');
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       final List<dynamic> conversationsData = responseData['data'];

//       final List<ConversationModel> conversations = conversationsData
//           .map((conversationJson) =>
//               ConversationModel.fromJson(conversationJson))
//           .toList();
//       final List<String> otherUserIds = conversations
//           .expand((conversation) => conversation.members)
//           .where((userId) => userId != userid)
//           .toList();

//       List<GetUserModel> otherUsers = [];

//       for (String userId in otherUserIds) {
//         final Response userResponse =
//             await UserRepo.getSingleUser(userid: userId);
//         if (userResponse.statusCode == 200) {
//           final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
//           final GetUserModel user = GetUserModel.fromJson(userJson);
//           otherUsers.add(user);
//         }
//       }
//       // users.addAll(otherUsers);

//       if (otherUsers.length == otherUserIds.length) {
//         emit(FetchAllConversationsSuccesfulState(
//           conversations: conversations,
//           otherUsers: otherUsers,
//           // filteredUsers: otherUsers,
//         ));
//       } else {
//         emit(FetchAllConversationsErrorState());
//       }
//     } else {
//       emit(FetchAllConversationsErrorState());
//     }
//   }

  FutureOr<void> allConversationsInitialFetchEvent(
      AllConversationsInitialFetchEvent event,
      Emitter<FetchAllConversationsState> emit) async {
    emit(FetchAllConversationsLoadingState());
    final userid = await getUserId();

    // Await the response from the API call
    final Response? response = await ChatRepo.getAllConversations();

    // Handle the case where response is null
    if (response == null) {
      emit(
          FetchAllConversationsErrorState()); // If response is null, emit error state
      return;
    }

    debugPrint('conversation fetch status code is-${response.statusCode}');
    debugPrint('fetch all conversations body is -${response.body}');

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> conversationsData = responseData['data'];

      // Map the conversation data to models
      final List<ConversationModel> conversations = conversationsData
          .map((conversationJson) =>
              ConversationModel.fromJson(conversationJson))
          .toList();

      // Get other user IDs from conversations
      final List<String> otherUserIds = conversations
          .expand((conversation) => conversation.members)
          .where((userId) => userId != userid)
          .toList();

      List<GetUserModel> otherUsers = [];

      // Fetch other users' details
      for (String userId in otherUserIds) {
        final Response userResponse =
            await UserRepo.getSingleUser(userid: userId);
        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
          final GetUserModel user = GetUserModel.fromJson(userJson);
          otherUsers.add(user);
        }
      }

      // Ensure we have all user data
      if (otherUsers.length == otherUserIds.length) {
        emit(FetchAllConversationsSuccesfulState(
          conversations: conversations,
          otherUsers: otherUsers,
        ));
      } else {
        emit(FetchAllConversationsErrorState());
      }
    } else {
      emit(FetchAllConversationsErrorState());
    }
  }

  // FutureOr<void> searchConversationsEvent(SearchConversationsEvent event,
  //     Emitter<FetchAllConversationsState> emit) async {
  //   final filteredUsers = users
  //       .where((element) => element.userName.contains(event.query))
  //       .toList();
  //   emit(FetchAllConversationsSuccesfulState(
  //       conversations: conversation,
  //       otherUsers: users,
  //       filteredUsers: filteredUsers));
  // }
}
