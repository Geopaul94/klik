part of 'teastbloc_bloc.dart';

@immutable
sealed class FollowersPostState {}






class FollowersPostInitialState extends FollowersPostState {}

class FollowersPostLoadingState extends FollowersPostState {}

class FollowersPostSuccessState extends FollowersPostState {
  final List<PostModel> posts;
  final bool hasMore;
  
  FollowersPostSuccessState({required this.posts, required this.hasMore});
}

class FollowersPostErrorState extends FollowersPostState {
  final String error;

  FollowersPostErrorState({required this.error});
}
