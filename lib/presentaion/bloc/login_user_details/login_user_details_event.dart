part of 'login_user_details_bloc.dart';

@immutable
sealed class LoginUserDetailsEvent {}
final class OnLoginedUserDataFetchEvent  extends LoginUserDetailsEvent{}

