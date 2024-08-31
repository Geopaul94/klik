import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/suggession_users_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'suggessions_event.dart';
part 'suggessions_state.dart';

class SuggessionsBloc extends Bloc<SuggessionsEvent, SuggessionsState> {
  SuggessionsBloc() : super(SuggessionsInitial()) {
    on<onSuggessionsIconclickedEvent>(_getUserSuggestions);
  }

  Future<void> _getUserSuggestions(
    onSuggessionsIconclickedEvent event,
    Emitter<SuggessionsState> emit
  ) async {
    emit(UserSuggessionsloadingState());
    try {
      final Response? result = await PostRepo.suggestions();
      if (result != null) {
        if (result.statusCode == 200) {
          final Map<String, dynamic> responseBody = jsonDecode(result.body);
          final SuggessionUsers suggestionUsers = SuggessionUsers.fromJson(responseBody);
          log(result.body);
          emit(UserSuggessionsSuccessState(Suggessions: suggestionUsers));
        } else if (result.statusCode == 500) {
          emit( UserSuggessionsErrorState(error: "Server not responding"));
        } else {
          emit( UserSuggessionsErrorState(error: "Unexpected status code: ${result.statusCode}"));
        }
      } else {
        emit( UserSuggessionsErrorState(error: "No response from server"));
      }
    } catch (e) {
      emit(UserSuggessionsErrorState(error: "An error occurred: ${e.toString()}"));
    }
  }
}