import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnavigator_state.dart';

class BottomnavigatorCubit extends Cubit<BottomnavigatorState> {
  BottomnavigatorCubit() : super(BottomnavigatorInitialState(index: 0));

  void bottomNavigatorButtonClicked( {required int index}) {
    emit(BottomnavigatorInitialState(index: index));
  }
}
