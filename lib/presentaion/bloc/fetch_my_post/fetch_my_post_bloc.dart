import 'package:bloc/bloc.dart';
import 'package:klik/domain/model/my_post_model.dart';
import 'package:meta/meta.dart';

part 'fetch_my_post_event.dart';
part 'fetch_my_post_state.dart';

class FetchMyPostBloc extends Bloc<FetchMyPostEvent, FetchMyPostState> {
  FetchMyPostBloc() : super(FetchMyPostInitial()) {
    on<FetchMyPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
