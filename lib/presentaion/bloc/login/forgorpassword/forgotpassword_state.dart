part of 'forgotpassword_bloc.dart';

@immutable
sealed class ForgotpasswordState {}

final class ForgotpasswordInitial extends ForgotpasswordState {}

final class ForgotpasswordLoadingstate extends ForgotpasswordState {}

final class ForgotpasswordSucessState extends ForgotpasswordState {}

final class ForgotpasswordErrorState extends ForgotpasswordState {
  final String error;

  ForgotpasswordErrorState({required this.error});
}



final class OtpverifiedLoadingState extends ForgotpasswordState {}
// reset password

final class ResetPasswordSuccesState extends ForgotpasswordState {}

final class ResetPasswordLoadingState extends ForgotpasswordState {}

final class ResetPasswordErrorState extends ForgotpasswordState {
  final String error;

  ResetPasswordErrorState({required this.error});
}













//opt verification
final class OtpverifiedSuccesState extends ForgotpasswordState {}

final class OtpverifiedErrorState extends ForgotpasswordState {
  final String error;

  OtpverifiedErrorState({required this.error});
}
