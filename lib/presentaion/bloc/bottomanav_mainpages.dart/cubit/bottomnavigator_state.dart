part of 'bottomnavigator_cubit.dart';

@immutable
sealed class BottomnavigatorState {}

final class BottomnavigatorInitialState extends BottomnavigatorState {
  final int index;

  BottomnavigatorInitialState({required this.index});

}
