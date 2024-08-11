part of 'resetpassword_bloc.dart';

@immutable
sealed class ResetpasswordEvent {}


class OnResetPasswordButtonClickedEvent extends ResetpasswordEvent {
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent(
      {required this.email, required this.password});
}
