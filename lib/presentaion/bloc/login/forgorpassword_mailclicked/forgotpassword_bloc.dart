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






 
  }
}

  










