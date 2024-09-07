part of 'getfollowers_post_bloc.dart';

@immutable
sealed class GetfollowersPostState {}

final class GetfollowersPostInitial extends GetfollowersPostState {}




final class GetfollowersPostLoadingState extends GetfollowersPostState {}

final class GetfollowersPostErrorState extends GetfollowersPostState {
  final String error;

  GetfollowersPostErrorState({required this.error});
}

final class GetfollowersPostSuccessState extends GetfollowersPostState {
 final List<AllPostsModel> HomePagePosts;
  final bool hasMore;

  GetfollowersPostSuccessState({required this.HomePagePosts, required this.hasMore});
  


}

