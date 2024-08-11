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



