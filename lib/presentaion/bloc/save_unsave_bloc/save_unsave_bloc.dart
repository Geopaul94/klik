import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/application/core/url/url_.dart';
import 'package:klik/domain/model/save_post_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'save_unsave_event.dart';
part 'save_unsave_state.dart';

class SaveUnsaveBloc extends Bloc<SaveUnsaveEvent, SaveUnsaveState> {
  SaveUnsaveBloc() : super(SaveUnsaveInitial()) {
    on<SaveUnsaveEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnUserSavePost>(_savePost);
    on<OnUserRemoveSavedPost>(_removeSavedPost);
  }


  Future<void> _savePost(
      OnUserSavePost event, Emitter<SaveUnsaveState> emit) async {
    emit(SavePostLoadingState());

    final response = await PostRepo.savepost(postId: event.postId);

    if (response != null) {
      if (response.statusCode == 200) {
  final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      final SavePostModel post = SavePostModel.fromJson(decodedJson);

        emit(SavePostSuccessfullState(post: post));
      } else if (response.statusCode == 500) {
        emit(SavePostErrorState(
            error: 'Server not responding. Try again later.'));
      } else {
        emit(SavePostErrorState(error: 'Something went wrong'));
      }
    } else {
      emit(SavePostErrorState(error: 'No response from server'));
    }
  }
}

Future<void> _removeSavedPost(
    OnUserRemoveSavedPost event, Emitter<SaveUnsaveState> emit) async {
  emit(RemoveSavedPostLoadingState());

  final response = await PostRepo.reomoveSavedpost(postId: event.postId);

  if (response != null) {
    if (response.statusCode == 200) {
  final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      final SavePostModel post = SavePostModel.fromJson(decodedJson);
      
      emit(RemoveSavedPostSuccessfulState(post: post));
    } else if (response.statusCode == 500) {
      emit(RemoveSavedPostErrorState(
          error: 'Server not responding. Try again later.'));
    } else {
      emit(RemoveSavedPostErrorState(error: 'Unexpected error occurred'));
    }
  } else {
    emit(RemoveSavedPostErrorState(error: 'No response from server'));
  }
}
