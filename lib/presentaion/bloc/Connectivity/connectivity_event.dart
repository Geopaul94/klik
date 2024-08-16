part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  ConnectivityChanged({required this.connectivityResult});
}
