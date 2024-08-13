part of 'user_post_bloc.dart';

@immutable
abstract class UserPostState {}

class UserPostInitial extends UserPostState {}

class ImagePickedLoadingState extends UserPostState {}

class ImagePickedSuccessState extends UserPostState {
  final XFile imageFile;

  ImagePickedSuccessState({required this.imageFile});
}

class ImagePickedErrorState extends UserPostState {
  final String error;

  ImagePickedErrorState({required this.error});
}

class ImageUploading extends UserPostState {}

class ImageUploaded extends UserPostState {}

class ImageUploadError extends UserPostState {
  final String error;

  ImageUploadError({required this.error});
}
