// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  DeleteCommentBloc() : super(DeleteCommentInitial()) {
    on<DeleteCommentEvent>((event, emit) {});
    on<DeleteCommentButtonClickEvent>(deleteCommentButtonClickEvent);
  }

  FutureOr<void> deleteCommentButtonClickEvent(
      DeleteCommentButtonClickEvent event,
      Emitter<DeleteCommentState> emit) async {
    emit(DeleteCommentLoadingState());
    final  response =
        await PostRepo.deleteComment(commentId: event.commentId);
    final responseBody =await jsonDecode(response!.body);
    if (response.statusCode == 200) {
      emit(DeleteCommentSuccesfulState(commentId: event.commentId));
    } else if (responseBody['status'] == 404) {
      emit(DeleteCommentCommentNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(DeleteCommentServerErrorState());
    }
  }
}
