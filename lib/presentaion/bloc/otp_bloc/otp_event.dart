part of 'otp_bloc.dart';

sealed class OtpVerifyButtonClickedEvent extends OtpState {
  final String email;
  final int otp;

  OtpVerifyButtonClickedEvent({required this.email, required this.otp});
}
