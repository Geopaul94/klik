part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeEvent {}


class onUserLikeButtonPressedEvent extends LikeUnlikeEvent{
  final String postId;

  onUserLikeButtonPressedEvent({required this.postId});
}


class onUserUnlikeButtonPressedEvent extends LikeUnlikeEvent{

    final String postId;

  onUserUnlikeButtonPressedEvent({required this.postId});
}