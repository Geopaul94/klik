import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/model/login_user_details_model.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'login_user_details_event.dart';
part 'login_user_details_state.dart';

class LoginUserDetailsBloc extends Bloc<LoginUserDetailsEvent, LoginUserDetailsState> {
  LoginUserDetailsBloc() : super(LoginUserDetailsInitial()) {
    on<LoginUserDetailsEvent>((event, emit) async{
 emit(LoginUserDetailsDataFetchLoadingState());
 final response =await UserRepo.fetchLoggedInUserDetails();
 if (response != null && response.statusCode ==200) {
   final responseBody =jsonDecode(response.body);
   final LoginUserModel model =LoginUserModel.fromJson(responseBody);
   
return emit(LoginUserDetailsDataFetchSuccessState(userModel: model));
   }else{

return emit(LoginUserDetailsDataFetchErrorState());

   }
    });
  }
}
