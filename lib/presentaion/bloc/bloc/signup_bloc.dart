import 'dart:async';

import 'package:bloc/bloc.dart';
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
      
    });
  }
}
