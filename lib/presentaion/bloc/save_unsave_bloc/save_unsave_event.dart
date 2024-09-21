part of 'save_unsave_bloc.dart';

@immutable
sealed class SaveUnsaveEvent {}


class OnUserSavePost extends SaveUnsaveEvent {
  final String postId;

  OnUserSavePost({required this.postId});
}

class OnUserRemoveSavedPost extends SaveUnsaveEvent {
  final String postId;

  OnUserRemoveSavedPost({required this.postId});
}