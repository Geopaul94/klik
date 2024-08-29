
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/post_listing_page.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/my_post_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
import 'package:shimmer/shimmer.dart';

class ScreenMyPost extends StatefulWidget {
  final int index;

  const ScreenMyPost(
      {super.key, required this.index, required List<MyPostModel> post});

  @override
  State<ScreenMyPost> createState() => _ScreenMyPostState();
}

class _ScreenMyPostState extends State<ScreenMyPost> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Posts'),
        automaticallyImplyLeading: true,
        // backgroundColor: kPrimaryColor,
      ),
      body: BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
        builder: (context, state) {
          if (state is FetchMyPostLoadingState) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: grey300!,
                    highlightColor: grey100!,
                    child: shimmerWidget1(media));
              },
            );
          } else if (state is FetchMyPostSuccesState) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No posts available.'));
            }
            return ListView.builder(
              controller:
                  ScrollController(initialScrollOffset: widget.index * 700),
              itemBuilder: (context, index) {
                final postItem = state.posts[index];
                return MyPostListingPageTile(
                  media: media,
                  mainImage: postItem.image.toString(),
                  profileImage: postItem.userId?.profilePic ?? '',
                  post: state.posts,

                  userName: postItem.userId?.userName.toString() ?? '',
                  postTime: postItem.createdAt == postItem.editedTime
                      ? formatDate(postItem.createdAt.toString())
                      : ("${formatDate(postItem.editedTime.toString())} (Edited)"),
                  description: postItem.description.toString(),
                  likeCount: postItem.likes!.length.toString(),
                  commentCount: '2', // need to add
                  likeButtonPressed: () {},
                  commentButtonPressed: () {
                    // context.read<GetCommentsBloc>().add(
                    //     CommentsFetchEvent(postId: postItem.id.toString()));
                    // commentBottomSheet(context, postItem, commentController,
                    //     formkey: _formkey,
                    //     // userName: profileuserName,
                    //     // profiePic: logginedUserProfileImage,ad
                    //     comments: _comments,
                    //     id: postItem.id.toString());
                  },
                  index: index,
                );
              },
              itemCount: state.posts.length,
            );
          } else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }
}
