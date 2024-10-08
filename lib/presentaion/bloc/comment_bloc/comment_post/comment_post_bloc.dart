import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'comment_post_event.dart';
part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  CommentPostBloc() : super(CommentPostInitial()) {
    on<CommentPostEvent>((event, emit) {});
    on<CommentPostButtonClickEvent>(commentPostButtonClickEvent);
  }

  FutureOr<void> commentPostButtonClickEvent(
      CommentPostButtonClickEvent event, Emitter<CommentPostState> emit) async {
    emit(CommentPostLoadingState());
    final Response result = await PostRepo.commentPost(
        postId: event.postId, userName: event.userName, content: event.content);
    final responseBody =await jsonDecode(result.body);
    if (result.statusCode == 200) {
      emit(CommentPostSuccesfulState(commentId: responseBody['commentId']));
    } else if (responseBody['status'] == 404) {
      emit(CommentPostNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(CommentPostServerErrorState());
    }
  }
}
