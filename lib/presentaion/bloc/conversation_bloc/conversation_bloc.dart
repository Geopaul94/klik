import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/all_message_model.dart';
import 'package:klik/domain/repository/chat_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<AllMessagesModel> messagesList = [];
  ConversationBloc() : super(ConversationInitial()) {
    on<ConversationEvent>((event, emit) {});
    on<CreateConversationButtonClickEvent>(createConversationButtonClickEvent);
    on<GetAllMessagesInitialFetchEvent>(getAllMessagesInitialFetchEvent);
    on<AddNewMessageEvent>(addNewMessageEvent);
  }

FutureOr<void> createConversationButtonClickEvent(
    CreateConversationButtonClickEvent event,
    Emitter<ConversationState> emit) async {
  emit(ConversationLoadingState());

  try {
    // API call to create conversation
    final Response response = await ChatRepo.createConversation(members: event.members);
    debugPrint('create conversation statuscode-${response.statusCode}');
    debugPrint('create conversation response body-${response.body}');
    
    // Parsing the response
    final Map<String, dynamic> responseData =await jsonDecode(response.body);
    
    // Check if the status code is 200 and 'data' exists in the response
    if (response.statusCode == 200 && responseData.containsKey('data')) {
      final String? conversationId = responseData['data']['_id'];
      
      if (conversationId != null) {
        // Success state with conversation ID
        emit(ConversationSuccesfulState(conversationId: conversationId));
      } else {
        // Handle missing conversation ID (fallback)
        debugPrint('Conversation ID is null');
        emit(ConversationErrorState());
      }
    } else {
      // Error due to invalid response structure or non-200 status code
      debugPrint('Error: Invalid response or status code');
      emit(ConversationErrorState());
    }
  } catch (e) {
    // Error handling
    debugPrint('Exception occurred: $e');
    emit(ConversationErrorState());
  }
}


//   FutureOr<void> getAllMessagesInitialFetchEvent(
//       GetAllMessagesInitialFetchEvent event,
//       Emitter<ConversationState> emit) async {
//     emit(GetAllMessagesLoadingState());
//     final Response response =
//         await ChatRepo.getAllMessages(conversationId: event.conversationId);
//     debugPrint("get all messages statuscode-${response.statusCode}");
//     if (response.statusCode == 200) {
//       final jsonResponse =await jsonDecode(response.body);


//       log( jsonResponse);
//       final List<dynamic>? dataList = jsonResponse['data'] as List<dynamic>?;
// if (dataList == null) {
//   throw Exception("Expected a list but got something else");
// }

//       messagesList =
//           dataList.map((json) => AllMessagesModel.fromJson(json)).toList();
  

//       messagesList.sort(
//   (a, b) => a.createdAt.compareTo(b.createdAt),
// );

//       emit(GetAllMessagesSuccesfulState(messagesList: messagesList));
//     } else {
//       emit(GetAllMessagesErrorState());
//     }
//   }



FutureOr<void> getAllMessagesInitialFetchEvent(
    GetAllMessagesInitialFetchEvent event,
    Emitter<ConversationState> emit) async {
  emit(GetAllMessagesLoadingState());
  try {
    final Response response =
        await ChatRepo.getAllMessages(conversationId: event.conversationId);
    debugPrint("get all messages statuscode-${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = await jsonDecode(response.body);
    log(jsonResponse.toString() as num);  // Log the JSON response to inspect structure

      final List<dynamic>? dataList = jsonResponse['data'] as List<dynamic>?;
      if (dataList == null) {
        throw Exception("Expected a list but got something else");
      }

      messagesList = dataList.map((json) => AllMessagesModel.fromJson(json)).toList();
      
      // Ensure that `createdAt` is a DateTime or num and is sorted correctly
      messagesList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      emit(GetAllMessagesSuccesfulState(messagesList: messagesList));
    } else {
      emit(GetAllMessagesErrorState());
    }
  } catch (e) {
    debugPrint('Exception occurred: $e');
    emit(GetAllMessagesErrorState());
  }
}








  FutureOr<void> addNewMessageEvent(
      AddNewMessageEvent event, Emitter<ConversationState> emit) async {
    messagesList.add(event.message);
    messagesList.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    emit(GetAllMessagesSuccesfulState(messagesList: messagesList));
  }
}
