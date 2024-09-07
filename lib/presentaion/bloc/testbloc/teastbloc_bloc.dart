import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:meta/meta.dart';

part 'teastbloc_event.dart';
part 'teastbloc_state.dart';

class FollowersPostBloc extends Bloc<FollowersPostEvent, FollowersPostState> {
  final List<PostModel> _posts = [];
  bool isFetching = false;

  FollowersPostBloc() : super(FollowersPostInitialState()) {
    on<FetchFollowersPostEvent>(_fetchFollowersPosts);
    on<LoadMoreFollowersPostEvent>(_loadMoreFollowersPosts);
  }

  Future<void> _fetchFollowersPosts(
    FetchFollowersPostEvent event,
    Emitter<FollowersPostState> emit,
  ) async {
    emit(FollowersPostLoadingState());
    try {
      final response = await PostRepo.getFollowersPost(event.page);

      if (response != null && response.statusCode == 200) {
        final List<PostModel> posts = PostModel.fromJsonList(jsonDecode(response.body)['data']);
        bool hasMore = posts.length == 10; 

        _posts.addAll(posts);
        emit(FollowersPostSuccessState(posts: _posts, hasMore: hasMore));
      } else {
        emit(FollowersPostErrorState(error: 'Failed to load posts.'));
      }
    } catch (e) {
      emit(FollowersPostErrorState(error: e.toString()));
    }
  }

  Future<void> _loadMoreFollowersPosts(
    LoadMoreFollowersPostEvent event,
    Emitter<FollowersPostState> emit,
  ) async {
    if (isFetching) return; 
    isFetching = true;

    try {
      final response = await PostRepo.getFollowersPost(event.page);

      if (response != null && response.statusCode == 200) {
        final List<PostModel> posts = PostModel.fromJsonList(jsonDecode(response.body)['data']);
        bool hasMore = posts.length == 10;

        _posts.addAll(posts);
        emit(FollowersPostSuccessState(posts: _posts, hasMore: hasMore));
      } else {
        emit(FollowersPostErrorState(error: 'Failed to load more posts.'));
      }
    } catch (e) {
      emit(FollowersPostErrorState(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}


class PostModel {
  final String title;
  final String content;

  PostModel({required this.title, required this.content});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'],
      content: json['content'],
    );
  }

  static List<PostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }
}
