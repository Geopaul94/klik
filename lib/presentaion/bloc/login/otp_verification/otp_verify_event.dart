part of 'otp_verify_bloc.dart';

@immutable
sealed class OtpVerifyEvent {}
class onVerifiPasswordButtonClicked extends OtpVerifyEvent {
  final String email;
  final String otp;

  onVerifiPasswordButtonClicked({required this.email, required this.otp});

 
 
}

