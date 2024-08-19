import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/followers_model.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'fetchfollowers_event.dart';
part 'fetchfollowers_state.dart';

class FetchFollowersBloc
    extends Bloc<FetchfollowersEvent, FetchfollowersState> {
  FetchFollowersBloc() : super(FetchfollowersInitial()) {
    on<OnfetchAllFollowersEvent>((event, emit) async {
      emit(FetchFollowersLoadingState());
      final Response result = await UserRepo.fetchFollowers();
      final responseBody = jsonDecode(result.body);
      if (result.statusCode == 200) {
        final FollowersModel followersModel =
            FollowersModel.fromJson(responseBody);
        return emit(FetchFollowersSuccesState(followersModel: followersModel));
      } else {
        return emit(FetchFollowersErrorState());
      }
    });
  }
}
