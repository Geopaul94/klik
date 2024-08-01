part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class OnRegisterButtonClickedEvent extends SignupEvent {
  // final UserModel user;

  final String userName;
  final String password;
  final String phoneNumber;
  final String email;

  OnRegisterButtonClickedEvent(
      {required this.userName,
      required this.password,
      required this.phoneNumber,
      required this.email});
}
