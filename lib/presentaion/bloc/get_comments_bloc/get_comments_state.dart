part of 'get_comments_bloc.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoadingState extends GetCommentsState{}
final class GetCommentsSuccessState extends GetCommentsState{


  final List<Comment>comments;

  GetCommentsSuccessState({required this.comments});
}
final class GetCommentsErrorState extends GetCommentsState{
  final String message;

  GetCommentsErrorState({required this.message});
}