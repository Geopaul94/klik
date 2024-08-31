import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_users_post_event.dart';
part 'get_users_post_state.dart';

class GetUsersPostBloc extends Bloc<GetUsersPostEvent, GetUsersPostState> {
  GetUsersPostBloc() : super(GetUsersPostInitial()) {
    on<GetUsersPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
