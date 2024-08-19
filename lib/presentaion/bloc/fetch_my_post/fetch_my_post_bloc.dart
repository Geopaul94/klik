import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:klik/domain/model/my_post_model.dart';
import 'package:klik/domain/repository/post_repo/post_repo.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_my_post_event.dart';
part 'fetch_my_post_state.dart';

class FetchMyPostBloc extends Bloc<FetchMyPostEvent, FetchMyPostState> {
  FetchMyPostBloc() : super(FetchMyPostInitial()) {
    on<FetchMyPostEvent>((event, emit)async {


      emit(FetchMyPostLoadingState());
      final response =await UserRepo.fetchUserPosts();
      if (response !=null&& response.statusCode ==200) {
        final responseBody =await response.body;
        final List<MyPostModel>posts =parsePostsFromJson(responseBody);

        return emit (FetchMyPostSuccesState(posts: posts));
      }else if(response != null){
final responseBody =jsonDecode(response.body);
return emit(FetchMyPostErrorState(error: responseBody["message"]));}

else {
        return emit(FetchMyPostErrorState(error: "something went wrong"));
      }
      
  
    });

on<OnMyPostDeleteButtonPressedEvent>((event,emit)async
{

emit(OnDeleteButtonClickedLoadingState());
var response =await PostRepo.deletePost(event.postId);
if(response !=null&& response.statusCode ==2200){
  add(FetchAllMyPostsEvent());
  return emit(OnDeleteButtonClickedSuccesState());

}else if(response != null){


  final responseBody = jsonDecode(response.body);
  return emit(OnDeleteButtonClickedErrrorState(error: responseBody['messsage']));

}else {
  return emit (OnDeleteButtonClickedErrrorState(error: 'Something went wrong'));
}

});

on<OnEditPostButtonClicked>((event ,emit)async{

emit(EditUserPostLoadingState());
final response =await  PostRepo.editPost(
            description: event.description,
            image: event.image,
            postId: event.postId,
            imageUrl: event.imageUrl);
        if (response != null && response.statusCode == 200) {
          add(FetchAllMyPostsEvent());
          return emit(EditUserPostSuccesState());
        } else if (response != null && response.statusCode == 500) {
          return emit(EditUserPosterrorState(error: 'Server not responding'));
        } else if (response != null) {
          final responseBody = jsonDecode(response.body);
          return emit(EditUserPosterrorState(error: responseBody['message']));
        } else {
          return emit(EditUserPosterrorState(error: 'Something went wrong'));
        }
      },
    );
  }
  } List<MyPostModel> parsePostsFromJson(String jsonString) {
    final List parsedData = jsonDecode(jsonString) as List;
    final List<MyPostModel> posts = [];

    for (var item in parsedData) {
      posts.add(MyPostModel.fromJson(item));
    }

    return posts;

}
