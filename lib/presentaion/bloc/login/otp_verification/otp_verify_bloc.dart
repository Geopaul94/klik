import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:klik/domain/repository/a/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  OtpVerifyBloc() : super(OtpVerifyInitial()) {
    on<onVerifiPasswordButtonClicked>(
      (event, emit) async {
        emit(OtpverifiedLoadingState());
        var response = await AuthenticationRepo.verifyOtpPasswordReset(
            event.email, event.otp);
        if (response != null && response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody["status"]) {
            return emit(OtpverifiedSuccesState());
          } else {
            if (kDebugMode) {
              print(responseBody);
            }
            return emit(OtpverifiedErrorState(error: 'invalid OTP'));
          }
        } else {
          return emit(OtpverifiedErrorState(error: 'something went wrong'));
        }
      },
    );
  }
}


