import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';


part 'get_connections_event.dart';
part 'get_connections_state.dart';

class GetConnectionsBloc
    extends Bloc<GetConnectionsEvent, GetConnectionsState> {
  GetConnectionsBloc() : super(GetConnectionsInitial()) {
    on<GetConnectionsEvent>((event, emit) {});
    on<ConnectionsInitilFetchEvent>(connectionsInitilFetchEvent);
  }

  FutureOr<void> connectionsInitilFetchEvent(ConnectionsInitilFetchEvent event,
      Emitter<GetConnectionsState> emit) async {
    emit(GetConnectionsLoadingState());
    final Response response =
        await UserRepo.getConnections(userId: event.userId);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);


     
      final int followersCount = responseBody['followersCount'];




      final int followingCount = responseBody['followingCount'];



 if (kDebugMode) {
        print(" GetConnectionsBloc           11111111111111111111111111 ==========$followersCount");
     print(" GetConnectionsBloc           11111111111111111111111111 ==========$followingCount");

      }



      emit(GetConnectionsSuccesfulState(
          followersCount: followersCount, followingsCount: followingCount));
    } else {
      emit(GetConnectionsErrorState());
    }
  }
}
