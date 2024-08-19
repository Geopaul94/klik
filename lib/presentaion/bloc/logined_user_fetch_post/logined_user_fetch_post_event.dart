part of 'logined_user_fetch_post_bloc.dart';

@immutable
sealed class LoginedUserFetchPostEvent {}
final class OnLoginedUserPostDataFetchEvent extends LoginedUserFetchPostEvent{}
