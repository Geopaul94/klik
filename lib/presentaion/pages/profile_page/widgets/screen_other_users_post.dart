import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/postmodel.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
import 'package:klik/presentaion/bloc/profile_bloc/profile_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/main_tile.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
import 'package:shimmer/shimmer.dart';

class ScreenOtherUserPosts extends StatelessWidget {
  final List<Post> posts;
  ScreenOtherUserPosts({super.key, required this.posts});
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _commentss = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Posts',
            style: appBarTitleStyle,
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfilePostFetchSuccesfulState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ExplorePageMainTile(
                    media: media,
                    mainImage: posts[index].image,
                    profileImage: posts[index].userId.profilePic,
                    userName: posts[index].userId.userName,
                    postTime: formatDate(posts[index].createdAt),
                    description: posts[index].description,
                    likeCount: posts[index].likes.length.toString(),
                    commentCount: '',
                    index: index,
                    removeSaved: () async {},
                    statesaved: state,
                    likeButtonPressed: () {},
                    commentButtonPressed: () async {
                      context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                          postId: posts[index].id.toString()));

                      AddComment(
                        profilePic: posts[index].userId.profilePic.toString(),
                        userName: posts[index].userId.userName.toString(),
                        comments: _commentss,
                        id: posts[index].id.toString(),
                        onCommentAdded: () {
                          // Dispatch the increment event
                          context
                              .read<CommentCountBloc>()
                              .add(IncrementCommentCount());
                        },
                        onCommentDeleted: () {
                          // Dispatch the decrement event
                          context
                              .read<CommentCountBloc>()
                              .add(DecrementCommentCount());
                        },
                      );

                      // commentBottomSheet(context, posts[index], commentController,
                      //     formkey: _formkey,
                      //     // userName: posts[index].userId.userName.toString(),
                      //     // profiePic: posts[index].userId.profilePic.toString(),
                      //     comments: _commentss,
                      //     id: posts[index].id.toString());
                      context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                          postId: posts[index].id.toString()));
                    }, commentes: const [],);
              },
              itemCount: posts.length,
            );
          } else {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: grey300!,
                    highlightColor: grey100!,
                    child: shimmerWidget1(media));
              },
            );
          }
        }));
  }
}
