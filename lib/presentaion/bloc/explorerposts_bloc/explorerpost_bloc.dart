import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/model/explore_posts_model.dart';

import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'explorerpost_event.dart';
part 'explorerpost_state.dart';

// class ExplorerpostBloc extends Bloc<ExplorerpostEvent, ExplorerpostState> {
//   ExplorerpostBloc() : super(ExplorerpostInitial()) {
//     on<ExplorerpostEvent>((event, emit) {
//       on<FetchExplorerPostsEvent>(_fetchexplorerposts);
//     });
//   }

//   Future _fetchexplorerposts(
//       FetchExplorerPostsEvent event, Emitter<ExplorerpostState> emit) async {
//     emit(ExplorerpostLoadingState());

//     try {
//       final response = await PostRepo.explorePosts();

//       if (response!.statusCode == 200) {
//         final responseBody =   await jsonDecode(response.body);

//         final List data = responseBody;

//         List<ExplorePostModel> posts =
//             data.map((e) => ExplorePostModel.fromJson(e)).toList();

//         emit(ExplorerpostSuccesstate(posts: posts));
//       } else {
//         emit(ExplorerpostErrorState());
//       }
//     } catch (e) {
//       emit(ExplorerpostErrorState());
//     }
//   }
// }


class ExplorerpostBloc extends Bloc<ExplorerpostEvent, ExplorerpostState> {
  ExplorerpostBloc() : super(ExplorerpostInitial()) {
    on<FetchExplorerPostsEvent>(_fetchexplorerposts);
  }

  Future<void> _fetchexplorerposts(
      FetchExplorerPostsEvent event, Emitter<ExplorerpostState> emit) async {
    emit(ExplorerpostLoadingState());

    try {
      final response = await PostRepo.explorePosts();

      if (response!.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final List data = responseBody;

        List<ExplorePostModel> posts =
            data.map((e) => ExplorePostModel.fromJson(e)).toList();

        emit(ExplorerpostSuccesstate(posts: posts));
      } else {
        emit(ExplorerpostErrorState());
      }
    } catch (e) {
      emit(ExplorerpostErrorState());
    }
  }
}
