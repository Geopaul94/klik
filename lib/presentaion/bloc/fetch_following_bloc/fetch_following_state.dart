part of 'fetch_following_bloc.dart';

@immutable
sealed class FetchFollowingState {}

final class FetchFollowingInitial extends FetchFollowingState {}
final class FetchFollowingSuccesState extends FetchFollowingState {
   final FollowingsModel model;

  FetchFollowingSuccesState({required this.model});
}
final class FetchFollowingErrorState extends FetchFollowingState {}
final class FetchFollowingLoadingState extends FetchFollowingState {}


