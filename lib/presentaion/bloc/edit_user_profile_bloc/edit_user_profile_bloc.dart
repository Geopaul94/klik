import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(EditUserProfileInitial()) {
    on<EditUserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
