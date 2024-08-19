part of 'logined_user_fetch_post_bloc.dart';

@immutable
sealed class LoginedUserFetchPostState {}

final class LoginedUserFetchPostInitial extends LoginedUserFetchPostState {}

final class LoginedUserFetchPostSuccessState
    extends LoginedUserFetchPostState {}

final class LoginedUserFetchPostErrorState extends LoginedUserFetchPostState {
  final String error;

  LoginedUserFetchPostErrorState({required this.error});
}

final class LoginedUserFetchPostLoadingState
    extends LoginedUserFetchPostState {}
