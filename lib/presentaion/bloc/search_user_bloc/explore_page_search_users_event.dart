part of 'explore_page_search_users_bloc.dart';

@immutable
sealed class ExplorePageSearchUsersEvent {}

final class OnSearchAllUsersEvent extends ExplorePageSearchUsersEvent {
  final String query;

  OnSearchAllUsersEvent({required this.query});
}
