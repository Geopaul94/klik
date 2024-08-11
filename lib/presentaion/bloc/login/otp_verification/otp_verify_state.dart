part of 'otp_verify_bloc.dart';

@immutable
sealed class OtpVerifyState {}

final class OtpVerifyInitial extends OtpVerifyState {}



final class OtpverifiedLoadingState extends OtpVerifyState {}




//opt verification
final class OtpverifiedSuccesState extends OtpVerifyState {}

final class OtpverifiedErrorState extends OtpVerifyState {
  final String error;

  OtpverifiedErrorState({required this.error});
}
