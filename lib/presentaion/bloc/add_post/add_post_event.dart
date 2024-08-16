// part of 'add_post_bloc.dart';

// @immutable
// abstract class AddPostEvent {}

// class PickImageFromGallery extends AddPostEvent {}

// class CaptureImage extends AddPostEvent {}

// class OnPostButtonClickedEvent extends AddPostEvent {
//   final String note;
//   final String imageFile;

//   OnPostButtonClickedEvent({required this.note, required this.imageFile});
// }
// class RemoveImage extends AddPostEvent {}class ClearImage extends AddPostEvent {}


part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class PickImageFromGallery extends AddPostEvent {}

class CaptureImage extends AddPostEvent {}

class OnPostButtonClickedEvent extends AddPostEvent {
  final String note;
  final String imagePath;

  OnPostButtonClickedEvent({required this.note, required this.imagePath});
}

class RemoveImage extends AddPostEvent {}

class ClearImage extends AddPostEvent {}
