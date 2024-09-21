part of 'save_unsave_bloc.dart';

@immutable
sealed class SaveUnsaveState {}

final class SaveUnsaveInitial extends SaveUnsaveState {}

class SavePostLoadingState extends SaveUnsaveState {}

class SavePostSuccessfullState extends SaveUnsaveState { final SavePostModel post;

  SavePostSuccessfullState({required this.post});}

class SavePostErrorState extends SaveUnsaveState {
  final String error;

  SavePostErrorState({required this.error});
}

class RemoveSavedPostLoadingState extends SaveUnsaveState {}

class RemoveSavedPostSuccessfulState extends SaveUnsaveState {}

class RemoveSavedPostErrorState extends SaveUnsaveState {
  final String error;

  RemoveSavedPostErrorState({required this.error});
}
