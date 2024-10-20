import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';

part 'fetch_saved_posts_event.dart';
part 'fetch_saved_posts_state.dart';

class FetchSavedPostsBloc extends Bloc<FetchSavedPostsEvent, FetchSavedPostsState> {
  FetchSavedPostsBloc() : super(FetchSavedPostsInitial()) {
        on<FetchSavedPostsEvent>((event, emit) {});
    on<SavedPostsInitialFetchEvent>(savedPostsInitialFetchEvent);
  }

//   FutureOr<void> savedPostsInitialFetchEvent(SavedPostsInitialFetchEvent event,
//       Emitter<FetchSavedPostsState> emit) async {
//     emit(FetchSavedPostsLoadingState());


    
//     final Response result = await PostRepo.fetchSavedPosts();
//     final responseBody = await jsonDecode(result.body);
//     final List data = responseBody;
//     debugPrint('saved post fetch statuscode-${result.statusCode}');

//     if (result.statusCode == 200) {
//       final List<SavedPostModel> posts = data.map((json) => SavedPostModel.fromJson(json)).toList();
//       emit(FetchSavedPostsSuccesfulState(posts: posts));
//     } else if (result.statusCode == 500) {
//       emit(FetchSavedPostsServerErrorState());
//     } else {
//       emit(FetchSavedPostsErrorState("Server not working "));
//     }
//   }


// }


FutureOr<void> savedPostsInitialFetchEvent(SavedPostsInitialFetchEvent event,
    Emitter<FetchSavedPostsState> emit) async {
  emit(FetchSavedPostsLoadingState());

  try {
    final Response? result = await PostRepo.fetchSavedPosts();
    
    if (result == null) {
      emit(FetchSavedPostsErrorState("Failed to fetch posts: No response received."));
      return;
    }

    debugPrint('saved post fetch statuscode-${result.statusCode}');

    if (result.statusCode == 200) {
      final List data = jsonDecode(result.body);
      final List<SavedPostModel> posts = data.map((json) => SavedPostModel.fromJson(json)).toList();
      emit(FetchSavedPostsSuccesfulState(posts: posts));
    } else if (result.statusCode == 401) {
      emit(FetchSavedPostsErrorState("Unauthorized access: Please log in."));
    } else if (result.statusCode == 500) {
      emit(FetchSavedPostsServerErrorState());
    } else {
      emit(FetchSavedPostsErrorState("Server returned an unexpected status code: ${result.statusCode}"));
    }
  } catch (e) {
    emit(FetchSavedPostsErrorState("An error occurred: ${e.toString()}"));
  }
}

}