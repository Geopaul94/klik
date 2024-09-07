part of 'getfollowers_post_bloc.dart';

@immutable
sealed class GetfollowersPostEvent {}

class FetchFollowersPostEvent extends GetfollowersPostEvent{
  final int page ;

  FetchFollowersPostEvent({required this.page});
  
}
class LoadMoreFollowersPostEvent extends GetfollowersPostEvent{
  final int page;

  LoadMoreFollowersPostEvent({required this.page});
}

