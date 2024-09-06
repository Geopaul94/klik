part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostState {}

final class FetchMyPostInitial extends FetchMyPostState {}





final class FetchMyPostSuccesState extends FetchMyPostState {
  final List<MyPostModel> posts;
  

  FetchMyPostSuccesState({required this.posts ,});
}

final class FetchMyPostLoadingState extends FetchMyPostState {}

final class FetchMyPostErrorState extends FetchMyPostState {
  final String error;

  FetchMyPostErrorState({required this.error});
}

final class OnDeleteButtonClickedLoadingState extends FetchMyPostState {}

final class OnDeleteButtonClickedSuccesState extends FetchMyPostState {}

final class OnDeleteButtonClickedErrrorState extends FetchMyPostState {
  final String error;

  OnDeleteButtonClickedErrrorState({required this.error});
}

final class EditUserPostLoadingState extends FetchMyPostState {}

final class EditUserPostSuccesState extends FetchMyPostState {}

final class EditUserPosterrorState extends FetchMyPostState {
  final String error;

  EditUserPosterrorState({required this.error});
}
