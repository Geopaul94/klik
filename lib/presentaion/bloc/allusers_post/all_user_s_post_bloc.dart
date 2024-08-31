import 'package:bloc/bloc.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:meta/meta.dart';

part 'all_user_s_post_event.dart';
part 'all_user_s_post_state.dart';
class AllUserSPostBloc extends Bloc<AllUserSPostEvent, AllUserSPostState> {
  AllUserSPostBloc() : super(AllUserSPostInitial()) {
    on<onUsersPostfetchEvent>(_onFetchUsersPost);
  }

  void _onFetchUsersPost(onUsersPostfetchEvent event, Emitter<AllUserSPostState> emit) {
    // Handle the event here
  }
}
