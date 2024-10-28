part of 'get_all_comment_bloc.dart';


@immutable

sealed class GetCommentsState {

}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoadingState extends GetCommentsState {}

class GetCommentsSuccsfulState extends GetCommentsState {
  final List<Comment> comments;
  final int commentsCount; // Add this property

  GetCommentsSuccsfulState({required this.comments})
      : commentsCount = comments.length; // Initialize commentsCount
}


final class GetCommentsServerErrorState extends GetCommentsState {
  final String error;

  GetCommentsServerErrorState({required this.error});
}
