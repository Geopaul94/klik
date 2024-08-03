part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


class LogingLoadingState extends LoginState{}

class   LogingLoadingErrorState  extends LoginState{
  final String error;

  LogingLoadingErrorState({required this.error});

 

  
}

class LogingSucessState extends LoginState{}

class LogingoogleButtonState extends LoginState{}