part of 'forgotpassword_bloc.dart';

@immutable
sealed class ForgotpasswordEvent {}

class onMailidSubmittedButtonClicked extends ForgotpasswordEvent {
  final String email;

  onMailidSubmittedButtonClicked({required this.email});
}



