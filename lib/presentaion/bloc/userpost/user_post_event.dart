part of 'user_post_bloc.dart';

@immutable
abstract class UserPostEvent {}

class PickImageFromGallery extends UserPostEvent {}

class CaptureImage extends UserPostEvent {}

class UploadImage extends UserPostEvent {
  final String note;
  final XFile imageFile;

  UploadImage({required this.note, required this.imageFile});
}
