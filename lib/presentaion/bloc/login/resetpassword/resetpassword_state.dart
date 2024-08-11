part of 'resetpassword_bloc.dart';

@immutable
sealed class ResetpasswordState {}

final class ResetpasswordInitial extends ResetpasswordState {}


// reset password

final class ResetPasswordSuccesState extends ResetpasswordState {}

final class ResetPasswordLoadingState extends ResetpasswordState {}

final class ResetPasswordErrorState extends ResetpasswordState {
  final String error;

  ResetPasswordErrorState({required this.error});
  
  
}
