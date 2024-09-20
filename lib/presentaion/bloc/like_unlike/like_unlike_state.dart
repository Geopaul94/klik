part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}


class LikePostLoadingState extends LikeUnlikeState{}
class LikePostSuccessfullState extends LikeUnlikeState{
    final String postId;

  LikePostSuccessfullState({required this.postId});
}
class LikePostErrorState extends LikeUnlikeState{}


class UnlikePostLoadingState extends LikeUnlikeState{}
class UnlikePostSuccessfullState extends LikeUnlikeState{
    final String postId;

  UnlikePostSuccessfullState({required this.postId});
}
class UnlikePostErrorState extends LikeUnlikeState{}
