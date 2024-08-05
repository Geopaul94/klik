part of 'forgotpassword_bloc.dart';

@immutable
sealed class ForgotpasswordEvent {}

class onMailidSubmittedButtonClicked extends ForgotpasswordEvent {
  final String email;

  onMailidSubmittedButtonClicked({required this.email});
}

class onVerifiPasswordButtonClicked extends ForgotpasswordEvent {
  final String email;
  final String otp;

  onVerifiPasswordButtonClicked({required this.email, required this.otp});

 
 
}



class OnResetPasswordButtonClickedEvent extends ForgotpasswordEvent {
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent(
      {required this.email, required this.password});
}
