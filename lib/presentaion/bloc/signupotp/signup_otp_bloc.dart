import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/repository/a/authentication_repo.dart';

import 'package:meta/meta.dart';

part 'signup_otp_event.dart';
part 'signup_otp_state.dart';

class SignupOtpBloc extends Bloc<SignupOtpEvent, SignupOtpState> {
  SignupOtpBloc() : super(SignupOtpInitial()) {
    on<onOtpVerificationButtonClickedEvent>((event, emit) async {
      emit(SignupOtpILoadingState());

      var response = await AuthenticationRepo.verifyOtp(
        event.email,
        event.otp,
      );

      if (response != null && response.statusCode == 200) {
        emit(SignupOtpSucessState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);

        return emit(SignupOtpErrorState(error: responseData["message"]));
      } else {
        return emit(SignupOtpErrorState(error: "something went wrong"));
      }
    });
  }
}
