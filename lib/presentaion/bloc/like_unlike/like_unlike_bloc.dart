import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikeUnlikeEvent>((event, emit) {});
    on<onUserLikeButtonPressedEvent>(likeButtonPressed);
    on<onUserUnlikeButtonPressedEvent>(unlikebuttonpressed);
  }

  Future<void> likeButtonPressed(
      onUserLikeButtonPressedEvent event, Emitter<LikeUnlikeState> emit) async {
    try {
      emit(LikePostLoadingState());
      final response = await PostRepo.likePost(postId: event.postId);
      final responseBody = jsonDecode(response!.body);

      debugPrint('Status code ++++++++++++++++++++++++++++: ${response.statusCode}');
      debugPrint('Response body-----------------------------------------------: ${response.body}');

      if (response.statusCode == 200) {
        emit(LikePostSuccessfullState());
      } else {
        if (responseBody['status'] == 404 ||
            responseBody['message'] == 'User already liked the post' ||
            responseBody['status'] == 500) {
          emit(LikePostErrorState());
        } else {
          // Handle other error cases or unknown responses
          emit(LikePostErrorState());
        }
      }
    } catch (e) {
      // Handle exceptions or errors
      emit(LikePostErrorState());
      debugPrint('Error in liking post: ${e.toString()}');
    }
  }

  Future<void> unlikebuttonpressed(onUserUnlikeButtonPressedEvent event,
      Emitter<LikeUnlikeState> emit) async {
    try {
      emit(LikePostLoadingState());
      final response = await PostRepo.unlikePost(postId: event.postId);
      final responseBody = jsonDecode(response!.body);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(UnlikePostSuccessfullState());
      } else {
        if (responseBody['status'] == 404 ||
            responseBody['message'] == 'User already liked the post' ||
            responseBody['status'] == 500) {
          emit(LikePostErrorState());
        } else {
          // Handle other error cases or unknown responses
          emit(UnlikePostErrorState());
        }
      }
    } catch (e) {
      // Handle exceptions or errors
      emit(UnlikePostErrorState());
      debugPrint('Error in unliking the post  post: ${e.toString()}');
    }
  }
}
