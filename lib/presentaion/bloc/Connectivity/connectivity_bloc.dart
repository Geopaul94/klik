import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  OverlayEntry? overlayEntry;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityChanged>((event, emit) {
      if (event.connectivityResult == ConnectivityResult.none) {
        emit(ConnectivityOffline());
      } else {
        emit(ConnectivityOnline());
      }
    });

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (connectivityResult) {
        add(ConnectivityChanged(connectivityResult: connectivityResult));
      },
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
