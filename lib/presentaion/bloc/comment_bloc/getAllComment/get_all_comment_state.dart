part of 'get_all_comment_bloc.dart';


@immutable

sealed class GetCommentsState {

}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoadingState extends GetCommentsState {}

final class GetCommentsSuccsfulState extends GetCommentsState {
  final List<Comment> comments;

  GetCommentsSuccsfulState({required this.comments});
}

final class GetCommentsServerErrorState extends GetCommentsState {
  final String error;

  GetCommentsServerErrorState({required this.error});
}
