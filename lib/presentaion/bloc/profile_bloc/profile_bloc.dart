import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:klik/domain/model/postmodel.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(ProfileInitial()) {
//     on<ProfileEvent>((event, emit) {
   

//    on<ProfileInitialPostFetchEvent>(_ProfileInitialPostFetchEvent);
//     });



//   }

//  Future <void> _ProfileInitialPostFetchEvent( ProfileInitialPostFetchEvent event , Emitter  <ProfileState> emit)async{
// emit(ProfilePostFetchLoadingState());
// final Response  result   =  await UserRepo.fetchUserPostsOther(userId: event.userId);

//   final responseBody = await jsonDecode(result.body);
//     final List<Post> posts =parsePosts(result.body);
//     debugPrint('user posts:-$responseBody');

//     if (result.statusCode == 200) {
//       // log(responseBody.toString());
//       emit(ProfilePostFetchSuccesfulState(posts: posts));
//     } else if (responseBody['status'] == 404) {
//       emit(ProfilePostFetchUserNotFoundState());
//     } else if (responseBody['status'] == 500) {
//       emit(ProfilePostFetchServerErrorState());
//     } else {
//       emit(ProfilePostFetchErrorState());
//     }
//       }
// }




// The error you're encountering occurs because you're calling on<ProfileInitialPostFetchEvent>(_ProfileInitialPostFetchEvent) multiple times. In the Bloc class, on is used to register event handlers, and each event type can only be registered once. You're trying to register the handler within another on<ProfileEvent> block, which is incorrect.




//corrected code

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Register the event handler directly in the constructor
    on<ProfileInitialPostFetchEvent>(_ProfileInitialPostFetchEvent);
  }

  Future<void> _ProfileInitialPostFetchEvent(
      ProfileInitialPostFetchEvent event, 
      Emitter<ProfileState> emit) async {
    emit(ProfilePostFetchLoadingState());

    final Response result = await UserRepo.fetchUserPostsOther(userId: event.userId);
    final responseBody = await jsonDecode(result.body);
    final List<Post> posts = parsePosts(result.body);
    debugPrint('user posts:- $responseBody');

    if (result.statusCode == 200) {
      emit(ProfilePostFetchSuccesfulState(posts: posts));
    } else if (responseBody['status'] == 404) {
      emit(ProfilePostFetchUserNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(ProfilePostFetchServerErrorState());
    } else {
      emit(ProfilePostFetchErrorState());
    }
  }
}
