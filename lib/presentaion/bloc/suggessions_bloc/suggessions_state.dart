part of 'suggessions_bloc.dart';

@immutable
sealed class SuggessionsState {}

final class SuggessionsInitial extends SuggessionsState {}

final class UserSuggessionsloadingState extends SuggessionsState {}

final class UserSuggessionsErrorState extends SuggessionsState {

  final String error;
  UserSuggessionsErrorState({required this.error});
}final class UserSuggessionsSuccessState extends SuggessionsState {
  final List<dynamic> Suggessions;

  UserSuggessionsSuccessState({required this.Suggessions});
}
