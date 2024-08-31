part of 'all_user_s_post_bloc.dart';

@immutable
sealed class AllUserSPostEvent {}

final class   onUsersPostfetchEvent  extends AllUserSPostEvent{

    final int startIndex;
  final int limit;

  onUsersPostfetchEvent({required this.startIndex, required this.limit});

}