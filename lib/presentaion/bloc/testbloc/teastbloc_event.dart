part of 'teastbloc_bloc.dart';

@immutable
sealed class FollowersPostEvent {}


class FetchFollowersPostEvent extends FollowersPostEvent {
  final int page;
  FetchFollowersPostEvent({required this.page});
}

class LoadMoreFollowersPostEvent extends FollowersPostEvent {
  final int page;
  LoadMoreFollowersPostEvent({required this.page});
}
