part of 'all_user_s_post_bloc.dart';

@immutable
sealed class AllUserSPostState {}

final class AllUserSPostInitial extends AllUserSPostState {



}


final class AllUserSPostLoadingState extends AllUserSPostState {}

final class AllUserSPostSuccessState extends AllUserSPostState {

  final List<PostModel>usersPost;

  AllUserSPostSuccessState({required this.usersPost});
}


final class AllUserSPostErrorState extends AllUserSPostState {
  final String  error;

  AllUserSPostErrorState({required this.error});
}