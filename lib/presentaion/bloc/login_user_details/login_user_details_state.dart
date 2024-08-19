part of 'login_user_details_bloc.dart';

@immutable
sealed class LoginUserDetailsState {}

final class LoginUserDetailsInitial extends LoginUserDetailsState {}

final class LoginUserDetailsDataFetchSuccessState
    extends LoginUserDetailsState {
  final LoginUserModel userModel;

  LoginUserDetailsDataFetchSuccessState({required this.userModel});
}

final class LoginUserDetailsDataFetchErrorState extends LoginUserDetailsState {}

final class LoginUserDetailsDataFetchLoadingState
    extends LoginUserDetailsState {}
