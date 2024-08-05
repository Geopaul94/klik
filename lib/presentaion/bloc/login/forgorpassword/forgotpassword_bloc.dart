import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:klik/domain/repository/a/authentication_repo.dart';
import 'package:klik/presentaion/bloc/signupotp/signup_otp_bloc.dart';
import 'package:meta/meta.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  ForgotpasswordBloc() : super(ForgotpasswordInitial()) {
    on<onMailidSubmittedButtonClicked>((event, emit) async {
      emit(ForgotpasswordLoadingstate());

      var response = await AuthenticationRepo.resetPasswordSentOtp(event.email);

      if (kDebugMode) {
        print("forgotpasswordbloc response: '$response'");
      }

      if (response != null && response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody["status"] == 200) {
          emit(ForgotpasswordSucessState());
        } else {
          emit(ForgotpasswordErrorState(error: responseBody["message"]));
        }
      } else {
        emit(ForgotpasswordErrorState(error: 'something went wrong'));
      }
    });
   on<onVerifiPasswordButtonClicked>(
      (event, emit) async {
        emit(ForgotpasswordLoadingstate());
        var response = await AuthenticationRepo.verifyOtpPasswordReset(
            event.email, event.otp);
        if (response != null && response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody["status"]) {
            return emit(ForgotpasswordSucessState());
          } else {
            if (kDebugMode) {
              print(responseBody);
            }
            return emit(ForgotpasswordErrorState(error: 'invalid OTP'));
          }
        } else {
          return emit(ForgotpasswordErrorState(error: 'something went wrong'));
        }
      },
    );







       on<OnResetPasswordButtonClickedEvent>(
      (event, emit) async {
        emit(ResetPasswordSuccesState());
        var response = await AuthenticationRepo.updatePassword(
            event.email, event.password);
        if (response != null && response.statusCode == 200) {
          return emit(ResetPasswordSuccesState());
        } else if (response != null) {
          var finalResponse = jsonDecode(response.body);
          return emit(ResetPasswordErrorState(error: finalResponse["message"]));
        } else {
          return emit(ResetPasswordErrorState(error: 'Something went wrong'));
        }
      },
    );
  }
}

  










