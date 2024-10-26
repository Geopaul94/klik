import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/chat_repository.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

part 'add_message_event.dart';
part 'add_message_state.dart';

// class AddMessageBloc extends Bloc<AddMessageEvent, AddMessageState> {
//   AddMessageBloc() : super(AddMessageInitial()) {
//     on<AddMessageEvent>((event, emit) {});
//     on<AddMessageButtonClickEvent>(addMessageButtonClickEvent);
//   }

  // FutureOr<void> addMessageButtonClickEvent(
  //     AddMessageButtonClickEvent event, Emitter<AddMessageState> emit) async {
  //   emit(AddMessageLoadingState());
  //   final Response response = await ChatRepo.addMessage(
  //       recieverId: event.recieverId,
  //       text: event.message,
  //       conversationId: event.conversationId,
  //       senderId: event.senderId);
  //   debugPrint('add message status code-${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     emit(AddMessageSuccesfulState());
  //   } else {
  //     emit(AddMessageErrorState());
  //   }
  // }

class AddMessageBloc extends Bloc<AddMessageEvent, AddMessageState> {
  AddMessageBloc() : super(AddMessageInitial()) {
    on<AddMessageEvent>((event, emit) {});
    on<AddMessageButtonClickEvent>(addMessageButtonClickEvent);
  }

  FutureOr<void> addMessageButtonClickEvent(
      AddMessageButtonClickEvent event, Emitter<AddMessageState> emit) async {
    emit(AddMessageLoadingState());

  debugPrint('add message status code recieverId-${event.recieverId}');


  debugPrint('add message status code text-${event.message}');

  debugPrint('add message status code  conversationId-${event.conversationId}');

  debugPrint('add message status code  senderId-${event.senderId}');


    final Response response = await ChatRepo.addMessage(
        
        recieverId: event.recieverId,
        text: event.message,
        conversationId: event.conversationId,


   //////////changed here  senderId: event.senderId);

        senderId: currentuserId,
        
        
          
            
            
            
            );

    
    debugPrint('add message status code-${response.statusCode}');


    if (response.statusCode == 200) {
      emit(AddMessageSuccesfulState());
    } else {
      emit(AddMessageErrorState());
    }
  }
}




// FutureOr<void> addMessageButtonClickEvent(
//     AddMessageButtonClickEvent event, Emitter<AddMessageState> emit) async {
//   emit(AddMessageLoadingState());

//   // Check if senderId is valid
//   if (event.senderId.isEmpty) {
//     emit(AddMessageErrorState()); // Emit error state if senderId is empty
//     debugPrint("SenderId is empty. Cannot send message.");
//     return;
//   }

//   try {
//     final Response response = await ChatRepo.addMessage(
//         recieverId: event.recieverId,
//         text: event.message,
//         conversationId: event.conversationId,
//         senderId: event.senderId);

//     debugPrint('Add message status code: ${response?.statusCode}');
//     if (response!.statusCode == 200) {
//       emit(AddMessageSuccesfulState());
//     } else {
//       emit(AddMessageErrorState());
//     }
//   } catch (e) {
//     debugPrint('Error adding message: $e');
//     emit(AddMessageErrorState());
//   }
// }







//  }


