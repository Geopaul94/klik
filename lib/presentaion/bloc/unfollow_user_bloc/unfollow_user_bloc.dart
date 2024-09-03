import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'unfollow_user_event.dart';
part 'unfollow_user_state.dart';


class UnfollowUserBloc extends Bloc<UnfollowUserEvent, UnfollowUserState> {
  UnfollowUserBloc() : super(UnfollowUserInitial()) {
    on<FollowUserButtonClickEvent>(_followUser);
    on<UnFollowUserButtonClickEvent>(_unfollowUser);
  }

  Future<void> _followUser(
    FollowUserButtonClickEvent event,
    Emitter<UnfollowUserState> emit
  ) async {
    emit(UnfollowUserLoadingState());
    try {
      final Response? response = await UserRepo.followUser(followeesId: event.followersId);

      debugPrint('follow statuscode-${response?.statusCode}');
      if (response != null && response.statusCode == 200) {
        emit(FollowUserSuccesfulState());
      } else {
        emit(FollowUserErrorState(error: 'Failed to follow user'));
      }
    } catch (e) {
      emit(FollowUserErrorState(error: e.toString()));
    }
  }

  Future<void> _unfollowUser(
    UnFollowUserButtonClickEvent event,
    Emitter<UnfollowUserState> emit
  ) async {
    emit(UnfollowUserLoadingState());
    try {
      final Response? response = await UserRepo.unFollowUser(followeesId: event.followersId);

      debugPrint('unfollow statuscode-${response?.statusCode}');
      if (response != null && response.statusCode == 200) {
        emit(UnfollowUserSuccesState());
      } else {
        emit(UnfollowUserErroState(error: 'Failed to unfollow user'));
      }
    } catch (e) {
      emit(UnfollowUserErroState(error: e.toString()));
    }
  }
}