part of 'fetchfollowers_bloc.dart';

@immutable
sealed class FetchfollowersState {}

final class FetchfollowersInitial extends FetchfollowersState {}
final class FetchFollowersSuccesState extends FetchfollowersState {
      final FollowersModel followersModel;

  FetchFollowersSuccesState({required this.followersModel});
}
final class FetchFollowersErrorState extends FetchfollowersState {


  final String error;

  FetchFollowersErrorState({required this.error});
}
final class FetchFollowersLoadingState extends FetchfollowersState {}
