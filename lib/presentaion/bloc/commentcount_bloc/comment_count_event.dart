part of 'comment_count_bloc.dart';

@immutable
sealed class CommentCountEvent {}


class IncrementCommentCount extends CommentCountEvent {}

class DecrementCommentCount extends CommentCountEvent {}
