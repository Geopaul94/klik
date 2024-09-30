part of 'comment_count_bloc.dart';

@immutable
sealed class CommentCountState {



   final int commentCount;

  CommentCountState(this.commentCount);
}




class CommentCountInitialState extends CommentCountState {
  CommentCountInitialState(int initialCount) : super(initialCount);
}

class CommentCountUpdatedState extends CommentCountState {
  CommentCountUpdatedState(int updatedCount) : super(updatedCount);
}
