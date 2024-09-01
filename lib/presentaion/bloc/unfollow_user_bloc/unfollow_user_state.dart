part of 'unfollow_user_bloc.dart';

@immutable
sealed class UnfollowUserState {}

final class UnfollowUserInitial extends UnfollowUserState {}

final class UnfollowUserLoadingState extends UnfollowUserState {}

final class UnfollowUserSuccesState extends UnfollowUserState {}

final class UnfollowUserErroState extends UnfollowUserState {
  final String error;

  UnfollowUserErroState({required this.error});
}



final class FollowUserErrorState extends UnfollowUserState {
 final String error;

  FollowUserErrorState({required this.error});

}

final class FollowUserSuccesfulState extends UnfollowUserState {}

final class FollowUserLoadingState extends UnfollowUserState {}
