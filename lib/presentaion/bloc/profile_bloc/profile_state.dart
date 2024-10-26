part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfilePostFetchLoadingState extends ProfileState {}

class ProfilePostFetchSuccesfulState extends ProfileState {
  final List<Post> posts;

  ProfilePostFetchSuccesfulState({required this.posts});
}

class ProfilePostFetchUserNotFoundState extends ProfileState {}

class ProfilePostFetchErrorState extends ProfileState {}

class ProfilePostFetchServerErrorState extends ProfileState {}
