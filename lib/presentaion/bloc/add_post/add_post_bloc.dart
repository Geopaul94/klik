

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_state.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';


class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final ImagePicker _picker = ImagePicker();

  AddPostBloc() : super(AddPostInitial()) {
    on<PickImageFromGallery>((event, emit) async {
      emit(ImagePickedLoadingState());
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(ImagePickedSuccessState(imageFile: pickedFile));
        } else {
          emit(ImagePickedErrorState(error: 'No image selected'));
        }
      } catch (e) {
        emit(ImagePickedErrorState(error: e.toString()));
      }
    });

    on<CaptureImage>((event, emit) async {
      emit(ImagePickedLoadingState());
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          emit(ImagePickedSuccessState(imageFile: pickedFile));
        } else {
          emit(ImagePickedErrorState(error: 'No image captured'));
        }
      } catch (e) {
        emit(ImagePickedErrorState(error: e.toString()));
      }
    });

    on<RemoveImage>((event, emit) {
      emit(AddPostInitial());
    });

    on<ClearImage>((event, emit) {
      emit(AddPostInitial());
    });

    on<OnPostButtonClickedEvent>((event, emit) async {
      emit(ImageUploadingState());

      final response = await PostRepo.addPost(event.note, event.imagePath);

      if (response != null && response.statusCode == 200) {
        emit(ImageUploadedState());

        if (kDebugMode) {
          print(response.body);

          try {
            switch (response.statusCode) {
              case 200:
                emit(ImageUploadedState());
                break;
              case 400:
                emit(ImageUploadErrorState(
                    error:
                        'Bad Request: The server could not understand the request due to invalid syntax.'));
                break;
              case 401:
                emit(ImageUploadErrorState(
                    error:
                        'Unauthorized: The client must authenticate itself to get the requested response.'));
                break;
              case 403:
                emit(ImageUploadErrorState(
                    error:
                        'Forbidden: The client does not have access rights to the content.'));
                break;
              case 404:
                emit(ImageUploadErrorState(
                    error:
                        'Not Found: The server cannot find the requested resource.'));
                break;
              case 500:
                emit(ImageUploadErrorState(
                    error:
                        'Internal Server Error: The server has encountered a situation it doesn\'t know how to handle.'));
                break;
              default:
                emit(ImageUploadErrorState(
                    error:
                        'Failed to upload image with status code: ${response.statusCode}'));
            }
          } catch (e) {
            emit(ImageUploadErrorState(error: e.toString()));
          }
        }
      }
    });
  }
}
