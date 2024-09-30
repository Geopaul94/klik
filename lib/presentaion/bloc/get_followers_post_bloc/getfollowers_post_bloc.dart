import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:klik/domain/model/followers_post_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';

import 'package:meta/meta.dart';

part 'getfollowers_post_event.dart';
part 'getfollowers_post_state.dart';

class GetfollowersPostBloc extends Bloc<GetfollowersPostEvent, GetfollowersPostState> {
  final List<FollowersPostModel> _posts = [];
  bool isFetching = false;
  bool hasMore = true; // To keep track of more data availability

  GetfollowersPostBloc() : super(GetfollowersPostInitial()) {
    on<FetchFollowersPostEvent>(_getFollowersPosts);
    on<LoadMoreFollowersPostEvent>(_loadMoreFollowersPosts);
  }

  // Fetching the initial posts


Future<void> _getFollowersPosts(
  FetchFollowersPostEvent event,
  Emitter<GetfollowersPostState> emit,
) async {
  debugPrint('Fetching posts for page: ${event.page}');
  if (isFetching) {
    debugPrint('Already fetching posts, ignoring this request.');
    return;
  }

  isFetching = true;
  emit(GetfollowersPostLoadingState());

  try {
    final response = await PostRepo.getFollowersPost(event.page);
    if (response != null && response.statusCode == 200) {
   
      var jsonResponse = jsonDecode(response.body);
   //   debugPrint(jsonResponse.toString()); 

     List<dynamic> postsJson = jsonResponse;
  
     for (var postJson in postsJson) {
  var postId = postJson['_id']; 
  if (postJson['userId'] != null && postJson['userId'] is Map) {
    var userId = postJson['userId']['_id']; 
    debugPrint('Post ID: $postId, User ID: $userId');
  } else {
    debugPrint('Post ID: $postId has no valid userId');
  }
}


     final List<FollowersPostModel> posts = FollowersPostModel.fromJsonList(postsJson);
      emit(GetfollowersPostSuccessState(HomePagePosts: posts, hasMore: posts.length == 10));
    } else {
      emit(GetfollowersPostErrorState(error: 'Failed to load posts.'));
    }
  } catch (e) {
    emit(GetfollowersPostErrorState(error: e.toString()));
  } finally {
    isFetching = false;
  }
}


  // Loading more posts when scrolling
  Future<void> _loadMoreFollowersPosts(
    LoadMoreFollowersPostEvent event,
    Emitter<GetfollowersPostState> emit,
  ) async {
    if (isFetching || !hasMore) return; // Prevent fetching if already fetching or no more data

    isFetching = true;
    try {
      final response = await PostRepo.getFollowersPost(event.page);

      if (response != null && response.statusCode == 200) {
        final List<FollowersPostModel> posts = FollowersPostModel.fromJsonList(jsonDecode(response.body)['data']);
        hasMore = posts.length == 10; 

        _posts.addAll(posts); 
        emit(GetfollowersPostSuccessState(HomePagePosts: _posts, hasMore: hasMore));
      } else {
        emit(GetfollowersPostErrorState(error: 'Failed to load more posts.'));
      }
    } catch (e) {
      emit(GetfollowersPostErrorState(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
