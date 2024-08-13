import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  final ImagePicker _picker = ImagePicker();

  UserPostBloc() : super(UserPostInitial()) {
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

    on<UploadImage>((event, emit) async {
      emit(ImageUploading());
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://your-api-endpoint.com/upload'),
        );
        request.fields['note'] = event.note;
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          event.imageFile.path,
        ));
        var response = await request.send();

        switch (response.statusCode) {
          case 200:
            emit(ImageUploaded());
            break;
          case 400:
            emit(ImageUploadError(error: 'Bad Request: The server could not understand the request due to invalid syntax.'));
            break;
          case 401:
            emit(ImageUploadError(error: 'Unauthorized: The client must authenticate itself to get the requested response.'));
            break;
          case 403:
            emit(ImageUploadError(error: 'Forbidden: The client does not have access rights to the content.'));
            break;
          case 404:
            emit(ImageUploadError(error: 'Not Found: The server cannot find the requested resource.'));
            break;
          case 500:
            emit(ImageUploadError(error: 'Internal Server Error: The server has encountered a situation it doesn\'t know how to handle.'));
            break;
          default:
            emit(ImageUploadError(error: 'Failed to upload image with status code: ${response.statusCode}'));
        }
      } catch (e) {
        emit(ImageUploadError(error: e.toString()));
      }
    });
  }
}
