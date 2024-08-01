import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/userModel.dart';
import 'package:klik/domain/repository/a/signup_repo.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<OnRegisterButtonClickedEvent>((event, emit) async {
      emit(SignupLoadingState());

      UserModel finalDatas = UserModel(
        userName: event.userName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        emailId: event.email,
      );




       try {
        Response? response = await AuthenticationRepo().sentOtp(finalDatas);

        if (response != null) {
          switch (response.statusCode) {
            case 200:
              emit(SignupSuccesState());
              break;
            case 400:
              final responseData = jsonDecode(response.body);
              emit(SignupErrorState(
                  error: responseData["message"] ?? "Bad request"));
              break;
            case 401:
              emit(SignupErrorState(
                  error:
                      "Unauthorized access. Please check your credentials."));
              break;
            case 403:
              emit(SignupErrorState(
                  error:
                      "Forbidden. You do not have permission to access this resource."));
              break;
            case 404:
              emit(SignupErrorState(error: "Resource not found."));
              break;
            case 500:
              emit(SignupErrorState(
                  error: "Internal server error. Please try again later."));
              break;
            default:
              emit(SignupErrorState(
                  error:
                      "Unexpected error occurred. Status code: ${response.statusCode}"));
              break;
          }
        } else {
          emit(SignupErrorState(
              error:
                  "No response from server. Please check your internet connection."));
        }
      } catch (e) {
        emit(SignupErrorState(error: "An exception occurred: $e"));
      }
    });
  }
}
