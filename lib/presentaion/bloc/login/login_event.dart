part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class onLoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  onLoginButtonClickedEvent({required this.email, required this.password});
}

class onGoogleButtonClickedEvent extends LoginEvent {

  onGoogleButtonClickedEvent();
}
