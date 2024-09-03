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

//   Future<void> _getUserSuggestions(
//     onSuggessionsIconclickedEvent event,
//     Emitter<SuggessionsState> emit
//   ) async {
//     emit(UserSuggessionsloadingState());
//     try {
//       final Response? result = await PostRepo.suggestions();
//       if (result != null) {
//         if (result.statusCode == 200) {
//           final List<dynamic> responseBody = jsonDecode(result.body);
//         final List<SuggessionUsers> suggestionUsers = responseBody.map((user) {
//           return SuggessionUsers.fromJson(user);
//         }).toList();
//         log(result.body);
//         emit(UserSuggessionsSuccessState(suggessions: suggestionUsers));
//         } else if (result.statusCode == 500) {
//           emit( UserSuggessionsErrorState(error: "Server not responding"));
//         } else {
//           emit( UserSuggessionsErrorState(error: "Unexpected status code: ${result.statusCode}"));
//         }
//       } else {
//         emit( UserSuggessionsErrorState(error: "No response from server"));
//       }
//     } catch (e) {
//       emit(UserSuggessionsErrorState(error: "An error occurred: ${e.toString()}"));
//     }
//   }
// }


Future<void> _getUserSuggestions(
  onSuggessionsIconclickedEvent event,
  Emitter<SuggessionsState> emit
) async {
  emit(UserSuggessionsloadingState());
  try {
    final Response? result = await PostRepo.suggestions();
    if (result != null) {
      if (result.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(result.body)['data'];
final List<SuggessionUsers> suggestionUsers = responseBody.map((userJson) {
  return SuggessionUsers.fromJson(userJson as Map<String, dynamic>);
}).toList();

        log(result.body);
        emit(UserSuggessionsSuccessState(Suggessions: suggestionUsers));
      } else if (result.statusCode == 500) {
        emit(UserSuggessionsErrorState(error: "Server not responding"));
      } else {
        emit(UserSuggessionsErrorState(error: "Unexpected status code: ${result.statusCode}"));
      }
    } else {
      emit(UserSuggessionsErrorState(error: "No response from server"));
    }
  } catch (e) {
    emit(UserSuggessionsErrorState(error: "An error occurred: ${e.toString()}"));
  }
}
}