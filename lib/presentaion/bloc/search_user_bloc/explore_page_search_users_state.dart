part of 'explore_page_search_users_bloc.dart';

@immutable
sealed class ExplorePageSearchUsersState {}

final class ExplorePageSearchUsersInitial extends ExplorePageSearchUsersState {}
final class ExplorePageSearchUserSuccesState extends ExplorePageSearchUsersState {
      final List<UserIdSearchModel> users;

  ExplorePageSearchUserSuccesState({required this.users});
}
final class ExplorePageSearchUsersErrorState extends ExplorePageSearchUsersState {}
final class ExplorePageSearchUsersLoadingState extends ExplorePageSearchUsersState {}
