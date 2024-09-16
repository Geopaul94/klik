part of 'get_all_comment_bloc.dart';

@immutable

sealed class GetCommentsEvent {}

class CommentsFetchEvent extends GetCommentsEvent {
  final String postId;

  CommentsFetchEvent({required this.postId});
}

class AddCommentEvent extends GetCommentsEvent{
  final Comment newComment;

  AddCommentEvent({required this.newComment});
}