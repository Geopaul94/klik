import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';

import 'package:meta/meta.dart';

part 'logined_user_fetch_post_event.dart';
part 'logined_user_fetch_post_state.dart';

class LoginedUserFetchPostBloc extends Bloc<LoginedUserFetchPostEvent, LoginedUserFetchPostState> {
  LoginedUserFetchPostBloc() : super(LoginedUserFetchPostInitial()) {
    on<LoginedUserFetchPostEvent>(homeInitialDatafetchEvent);}
  
  
  
  Future <void>homeInitialDatafetchEvent(LoginedUserFetchPostEvent event, Emitter<LoginedUserFetchPostState>emit)async{

    emit(LoginedUserFetchPostLoadingState()); final Response? response = await PostRepo.fetchPosts();  if (response != null && response.statusCode == 200) {
      return emit(LoginedUserFetchPostSuccessState());
    }if (response != null) { 
      final responseBody = jsonDecode(response.body);
      if (responseBody['status'] == 500) {
        return emit(LoginedUserFetchPostErrorState(
            error: 'server not responding try after sometime'));
      }
    } else {
      return emit(
          LoginedUserFetchPostErrorState(error: 'something went wrong'));
    }
  }
}
