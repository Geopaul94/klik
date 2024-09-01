part of 'unfollow_user_bloc.dart';

@immutable
sealed class UnfollowUserEvent {}
class FollowUserButtonClickEvent extends UnfollowUserEvent {
  final String followersId;

  FollowUserButtonClickEvent({required this.followersId});
}

class UnFollowUserButtonClickEvent extends UnfollowUserEvent {
  final String followersId;

  UnFollowUserButtonClickEvent({required this.followersId});
}
