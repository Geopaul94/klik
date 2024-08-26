import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'get_comments_event.dart';
part 'get_comments_state.dart';

class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState> {
  GetCommentsBloc() : super(GetCommentsInitial()) {
    on<GetCommentsEvent>((event, emit) {
      // You can handle other events here
    });

    on<CommentsFetchEvent>(commentsFetchEvent);
  }

  FutureOr<void> commentsFetchEvent(
      CommentsFetchEvent event, Emitter<GetCommentsState> emit) async {
    emit(GetCommentsLoadingState());

    try {
      final Response result = await PostRepo.getAllComments(postId: event.postId);

      if (result.statusCode == 200) {
        final responseBody = jsonDecode(result.body);
        List<Comment> comments = List<Comment>.from(
            responseBody['comments'].map((commentJson) => Comment.fromJson(commentJson)));
        emit(GetCommentsSuccessState(comments: comments));
      } else if (result.statusCode == 400) {
        emit(GetCommentsErrorState(message: "Bad request. Please check the post ID."));
      } else if (result.statusCode == 401) {
        emit(GetCommentsErrorState(message: "Unauthorized. Please log in."));
      } else if (result.statusCode == 403) {
        emit(GetCommentsErrorState(message: "Forbidden. You don’t have permission to view these comments."));
      } else if (result.statusCode == 404) {
        emit(GetCommentsErrorState(message: "Post not found."));
      } else if (result.statusCode == 500) {
        emit(GetCommentsErrorState(message: "Server error. Please try again later."));
      } else {
        emit(GetCommentsErrorState(message: "Unexpected error. Status code: ${result.statusCode}."));
      }
    } catch (e) {
      emit(GetCommentsErrorState(message: "An error occurred: ${e.toString()}"));
    }
  }
}
