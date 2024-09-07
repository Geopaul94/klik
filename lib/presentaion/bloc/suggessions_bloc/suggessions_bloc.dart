import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/suggession_users_model.dart';
import 'package:klik/domain/model/userModel.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'suggessions_event.dart';
part 'suggessions_state.dart';

class SuggessionsBloc extends Bloc<SuggessionsEvent, SuggessionsState> {
  final List<SuggessionUserModel> _suggestionUsers = []; // List to store suggestion users

  SuggessionsBloc() : super(SuggessionsInitial()) {
    on<onSuggessionsIconclickedEvent>(_getUserSuggestions);
    on<RemoveSuggessionUserEvent>(_removeSuggestionUser); // Register the event
  }

  Future<void> _getUserSuggestions(
    onSuggessionsIconclickedEvent event,
    Emitter<SuggessionsState> emit
  ) async {
    emit(UserSuggessionsloadingState());
    try {
      final Response? result = await UserRepo.suggestions();
      if (result != null && result.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(result.body)['data'];
        _suggestionUsers.clear(); // Clear the list before updating
        _suggestionUsers.addAll(responseBody.map((userJson) {
          return SuggessionUserModel.fromJson(userJson as Map<String, dynamic>);
        }).toList());

        emit(UserSuggessionsSuccessState(_suggestionUsers));
      } else {
        emit(UserSuggessionsErrorState(error: "Unexpected status code: ${result?.statusCode}"));
      }
    } catch (e) {
      emit(UserSuggessionsErrorState(error: "An error occurred: ${e.toString()}"));
    }
  }

  Future<void> _removeSuggestionUser(
    RemoveSuggessionUserEvent event, 
    Emitter<SuggessionsState> emit
  ) async {
    try {
      _suggestionUsers.removeWhere((user) => user.id == event.userId); // Remove user by ID
      emit(UserSuggessionsSuccessState(_suggestionUsers)); // Update the UI with the new list
    } catch (e) {
      emit(UserSuggessionsErrorState(error: "Failed to remove user"));
    }
  }
}






















