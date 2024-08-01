part of 'signup_otp_bloc.dart';

@immutable
sealed class SignupOtpEvent {}

class onOtpVerificationButtonClickedEvent extends SignupOtpEvent{
  final String otp;
  final String email;

  onOtpVerificationButtonClickedEvent({required this.otp, required this.email});
}
