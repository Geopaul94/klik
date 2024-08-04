import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/a/authentication_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<onLoginButtonClickedEvent>(
      (event, emit) async {
        emit(LogingLoadingState());
        final response =
            await AuthenticationRepo.userLogin(event.email, event.password);

        if (response != null && response.statusCode == 200) {
          return emit(LogingSucessState());
        
        } else if (response != null) {
          final responseData = jsonDecode(response.body);
          return emit(LogingLoadingErrorState(error: responseData["message"]));
        } else {
          return emit(LogingLoadingErrorState(error: "something went wrong"));
        }
      },
    );
    on<onGoogleButtonClickedEvent>((event, emit) async {
      emit(LogingoogleButtonState());

      final response = await siginWithGoogle();
      if (response != null &&
          response.user != null &&
          response.user!.email != null) {
        var email = response.user!.email;

        Response? finalResponse = await AuthenticationRepo.googleLogin(email!);
        if (finalResponse != null && finalResponse.statusCode == 200) {
          return emit(LogingSucessState());
        } else if (finalResponse != null) {
          final errormessage = jsonDecode(finalResponse.body);
          emit(LogingLoadingErrorState(error: errormessage["message"]));
        } else {
          return emit(LogingLoadingErrorState(error: "Something went wrong"));
        }
      } else {
        emit(LogingLoadingErrorState(error: "account not found "));
      }
      // TODO: implement event handler
    });
  }
}
