import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/edit_details_model.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(EditUserProfileInitial()) {
    on<OnEditProfileButtonClickedEvent>((event, emit) async {
      emit(EditUserProfileLoadingState());
      
      final Response result = await UserRepo.editProfile(
        image: event.editDetailsModel.image,
        name: event.editDetailsModel.name,
        bio: event.editDetailsModel.bio,
        imageUrl: event.editDetailsModel.imageUrl,
        bgImage: event.editDetailsModel.bgImage,
        bgImageUrl: event.editDetailsModel.bgImageUrl,
      );

      final responseBody = jsonDecode(result.body);

      if (result.statusCode == 200) {
        emit(EditUserProfileSuccesState());
      } else if (responseBody['status'] == 401) {
        emit(EditUserProfileErrorState(error: 'Unauthorized access'));
      } else if (responseBody['message'] == 'Something went wrong while updating the post') {
        emit(EditUserProfileErrorState(error: 'Error updating profile'));
      } else {
        emit(EditUserProfileErrorState(
            error: 'Something went wrong, check your internet connection and try again'));
      }
    });
  }
}
