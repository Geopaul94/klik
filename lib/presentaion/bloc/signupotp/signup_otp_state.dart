part of 'signup_otp_bloc.dart';

@immutable
sealed class SignupOtpState {}

final class SignupOtpInitial extends SignupOtpState {}

final class SignupOtpILoadingState extends SignupOtpState {}

final class SignupOtpErrorState extends SignupOtpState {
  final String error;

  SignupOtpErrorState({required this.error});
}

final class SignupOtpSucessState extends SignupOtpState {}
