import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'get_all_comment_event.dart';
part 'get_all_comment_state.dart';






class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState> {
  GetCommentsBloc() : super(GetCommentsInitial()) {
    on<GetCommentsEvent>((event, emit) {});
    on<CommentsFetchEvent>(commentsFetchEvent);
  }

  FutureOr<void> commentsFetchEvent(
      CommentsFetchEvent event, Emitter<GetCommentsState> emit) async {
    emit(GetCommentsLoadingState());
    final Response result =
        await PostRepo.getAllCommentPost(postId: event.postId);
    if (result.statusCode == 200) {
      final responseBody =  await jsonDecode(result.body);
      List<Comment> comments = List<Comment>.from(responseBody['comments']
          .map((commentJson) => Comment.fromJson(commentJson)));
      emit(GetCommentsSuccsfulState(comments: comments));
    } else if (result.statusCode == 500) {
      emit(GetCommentsServerErrorState(error: 'Something went wrong'));
    }
  }
}
