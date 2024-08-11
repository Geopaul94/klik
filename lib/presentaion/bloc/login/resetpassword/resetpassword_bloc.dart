import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/repository/a/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  ResetpasswordBloc() : super(ResetpasswordInitial()) {
    on<OnResetPasswordButtonClickedEvent>((event, emit) async {
      emit(ResetPasswordSuccesState());
      var response =
          await AuthenticationRepo.updatePassword(event.email, event.password);
      if (response != null && response.statusCode == 200) {
        return emit(ResetPasswordSuccesState());
      } else if (response != null) {
        var finalResponse = jsonDecode(response.body);
        return emit(ResetPasswordErrorState(error: finalResponse["message"]));
      } else {
        return emit(ResetPasswordErrorState(error: 'Something went wrong'));
      }
    });
  }
}
