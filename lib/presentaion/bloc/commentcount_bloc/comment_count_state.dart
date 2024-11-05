part of 'comment_count_bloc.dart';

@immutable
sealed class CommentCountState {



   final int commentCount;

  const CommentCountState(this.commentCount);
}




class CommentCountInitialState extends CommentCountState {
  const CommentCountInitialState(super.initialCount);
}

class CommentCountUpdatedState extends CommentCountState {
  const CommentCountUpdatedState(super.updatedCount);
}
