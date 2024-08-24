part of 'bottomnavigator_cubit.dart';

@immutable
sealed class BottomnavigatorState {}


class BottomnavigatorInitialState extends BottomnavigatorState {
  final int index;
  BottomnavigatorInitialState({required this.index});
}

class BottomnavigatorNavigateState extends BottomnavigatorState {
  final int index;
  BottomnavigatorNavigateState({required this.index});
}
