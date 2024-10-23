import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/followers_model.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'fetchfollowers_event.dart';
part 'fetchfollowers_state.dart';

// class FetchFollowersBloc
//     extends Bloc<FetchfollowersEvent, FetchfollowersState> {
//   FetchFollowersBloc() : super(FetchfollowersInitial()) {
//     on<OnfetchAllFollowersEvent>((event, emit) async {
//       emit(FetchFollowersLoadingState());
//       final Response result = await UserRepo.fetchFollowers();
//       final responseBody =await jsonDecode(result.body);
//       if (result.statusCode == 200) {
//         final FollowersModel followersModel =FollowersModel.fromJson(responseBody);
//         return emit(FetchFollowersSuccesState(followersModel: followersModel));
//       } else {
//         return emit(FetchFollowersErrorState());
//       }
//     });
//   }
// }


class FetchFollowersBloc extends Bloc<FetchfollowersEvent, FetchfollowersState> {
  FetchFollowersBloc() : super(FetchfollowersInitial()) {
    on<OnfetchAllFollowersEvent>((event, emit) async {
      emit(FetchFollowersLoadingState());
      try {
        final Response result = await UserRepo.fetchFollowers();
        
        // Check the status code before trying to decode the response
        if (result.statusCode == 200) {
          // Decode the response only if it's successful (status code 200)
          final responseBody = jsonDecode(result.body);
          final FollowersModel followersModel = FollowersModel.fromJson(responseBody);
          emit(FetchFollowersSuccesState(followersModel: followersModel));
        } else if (result.statusCode == 429) {
          // Handle rate limit error
          emit(FetchFollowersErrorState(error: "Rate limit exceeded. Please try again later."));
        } else {
          // Handle other error status codes
          emit(FetchFollowersErrorState(error: "Error: ${result.statusCode}"));
        }
      } catch (e) {
        // Catch any other exceptions (like parsing errors or network issues)
        emit(FetchFollowersErrorState(error: "An unexpected error occurred: $e"));
      }
    });
  }
}
