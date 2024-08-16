// // part of 'add_post_bloc.dart';

// // @immutable
// // abstract class AddPostState {}

// // class AddPostInitial extends AddPostState {}

// // class ImagePickedLoadingState extends AddPostState {}

// // class ImagePickedSuccessState extends AddPostState {
// //   final String imageFile;

// //   ImagePickedSuccessState({required this.imageFile});
// // }

// // class ImagePickedErrorState extends AddPostState {
// //   final String error;

// //   ImagePickedErrorState({required this.error});
// // }

// // class ImageUploadingState extends AddPostState {}

// // class ImageUploadedState  extends AddPostState {}

// // class ImageUploadErrorState  extends AddPostState {
// //   final String error;

// //   ImageUploadErrorState({required this.error});

// // }
// // final class AddPostLoadingstate extends AddPostState {}

// // final class SelectImageToPostSuccessState extends AddPostState {}

// // final class SelectImageToPostError extends AddPostState {}

// // final class SelectImageToPostLoadingstate extends AddPostState {}



// part of 'add_post_bloc.dart';

// @immutable
// abstract class AddPostState {}

// class AddPostInitial extends AddPostState {}

// class ImagePickedLoadingState extends AddPostState {}

// class ImagePickedSuccessState extends AddPostState {
//   final String imagePath;

//   ImagePickedSuccessState({required this.imagePath});
// }

// class ImagePickedErrorState extends AddPostState {
//   final String error;

//   ImagePickedErrorState({required this.error});
// }

// class ImageUploadingState extends AddPostState {}

// class ImageUploadedState extends AddPostState {}

// class ImageUploadErrorState extends AddPostState {
//   final String error;

//   ImageUploadErrorState({required this.error});
// }

// class AddPostLoadingState extends AddPostState {}

// class SelectImageToPostSuccessState extends AddPostState {}

// class SelectImageToPostError extends AddPostState {}

// class SelectImageToPostLoadingState extends AddPostState {}



// add_post_state.dart

import 'package:image_picker/image_picker.dart';

abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class ImagePickedLoadingState extends AddPostState {}

class ImagePickedSuccessState extends AddPostState {
  final XFile imageFile; // Use XFile for handling the image

  ImagePickedSuccessState({required this.imageFile});
}

class ImagePickedErrorState extends AddPostState {
  final String error;

  ImagePickedErrorState({required this.error});
}

class ImageUploadingState extends AddPostState {}

class ImageUploadedState extends AddPostState {}

class ImageUploadErrorState extends AddPostState {
  final String error;

  ImageUploadErrorState({required this.error});
}
