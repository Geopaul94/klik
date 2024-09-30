import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comment_count_event.dart';
part 'comment_count_state.dart';

class CommentCountBloc extends Bloc<CommentCountEvent, CommentCountState> {
  CommentCountBloc(int initialCount)
      : super(CommentCountInitialState(initialCount)) {
    on<IncrementCommentCount>((event, emit) {
      emit(CommentCountUpdatedState(state.commentCount + 1));
    });

    on<DecrementCommentCount>((event, emit) {
      emit(CommentCountUpdatedState(state.commentCount - 1));
    });
  }
}
