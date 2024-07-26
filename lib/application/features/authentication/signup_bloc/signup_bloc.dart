import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:klik/application/features/authentication/signup_bloc/signup_event.dart';
import 'package:klik/domain/model/userModel.dart';


part 'signup_state.dart';

class SignupBloc extends Bloc<SignUpEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<OnSignupButtonClickedEvent>((event, emit) async {
      if (kDebugMode) {
        print("loading");
      }
      emit(SignupLoadingState());

       UserModel finalDatas = UserModel(
        userName: event.userName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        emailId: event.email,
      );
    });
  }
}
