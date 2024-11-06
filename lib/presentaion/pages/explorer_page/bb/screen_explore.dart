// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:klik/application/core/widgets/customeAppbar_row.dart';
// import 'package:klik/domain/model/comment_model.dart';
// import 'package:klik/infrastructure/functions/serUserloggedin.dart';
// import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
// import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
// import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
// import 'package:klik/presentaion/pages/explorer_page/bb/main_tile.dart';
// import 'package:klik/presentaion/pages/homepage/add_comment.dart';
// import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
// import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';
// import 'package:shimmer/shimmer.dart';

// class ScreenExplore extends StatelessWidget {
//   ScreenExplore({super.key});
//   TextEditingController commentController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   final List<Comment> _comments = [];

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: CustomeAppbarRow(
//         height: height,
//         width: width,
//         title: 'Explore',
//         onBackButtonPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       body: SafeArea(child: BlocBuilder<ExplorerpostBloc, ExplorerpostState>(
//         builder: (context, state) {
//           if (state is ExplorerpostSuccesstate) {
//             if (state.posts.isNotEmpty) {
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   return ExplorePageMainTile(
//                     media: media,
//                     mainImage: state.posts[index].image,
//                     profileImage: state.posts[index].userId.profilePic,
//                     userName: state.posts[index].userId.userName,
//                     postTime: formatDate(state.posts[index].createdAt),
//                     description: state.posts[index].description,
//                     likeCount: state.posts[index].likes.length.toString(),
//                     commentCount: '',
//                     index: index,
//                     removeSaved: () async {},
//                     statesaved: state,
//                     likeButtonPressed: () {},
//                     commentButtonPressed: () {
//                       context.read<GetCommentsBloc>().add(CommentsFetchEvent(
//                           postId: state.posts[index].id.toString()));

//                       // commentBottomSheet(
//                       //     context, state.posts[index], commentController,
//                       //     formkey: _formkey,
//                       //     // userName:
//                       //     //     state.posts[index].userId.userName.toString(),
//                       //     //
//                       //     //     .toString(),
//                       //     comments: _comments,
//                       //     id: state.posts[index].id.toString());

//                       AddComment(
//                         profilePic: state.posts[index].userId.profilePic,
//                         userName: state.posts[index].userId.userName,
//                         comments: _comments,
//                         id: state.posts[index].userId.id,
//                         onCommentAdded: () {
//                           // Dispatch the increment event
//                           context
//                               .read<CommentCountBloc>()
//                               .add(IncrementCommentCount());
//                         },
//                         onCommentDeleted: () {
//                           // Dispatch the decrement event
//                           context
//                               .read<CommentCountBloc>()
//                               .add(DecrementCommentCount());
//                         },
//                       );

//                       context.read<GetCommentsBloc>().add(CommentsFetchEvent(
//                           postId: state.posts[index].id.toString()));
//                     },
//                     commentes: _comments,
//                   );
//                 },
//                 itemCount: state.posts.length,
//               );
//             } else {
//               return errorStateWidget('No data found ', greyMeduim);
//             }
//           } else if (state is ExplorerpostLoadingState) {
//             return ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) => Shimmer.fromColors(
//                 baseColor: grey300!,
//                 highlightColor: grey100!,
//                 child: shimmerWidget1(media),
//               ),
//             );
//           } else {
//             return errorStateWidget(
//                 'something went wrong try refreshing', greyMeduim);
//           }
//         },
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/explore_posts_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/main_tile.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/profile_page/simmer_widget.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';
import 'package:shimmer/shimmer.dart';

class ScreenExplore extends StatelessWidget {
  final List<ExplorePostModel> posts; // Use your actual model type
  final int startIndex;

  ScreenExplore({super.key, required this.posts, required this.startIndex});
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<ExplorePostModel> displayPosts = posts.sublist(startIndex);
    return Scaffold(
      appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: 'Explore',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: BlocBuilder<ExplorerpostBloc, ExplorerpostState>(
          builder: (context, state) {
            if (state is ExplorerpostSuccesstate) {
              if (state.posts.isNotEmpty) {
                return ListView.builder(
                  itemCount: displayPosts.length,
                  itemBuilder: (context, index) {
                    final post = displayPosts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10), // Gap between each item
                      padding: const EdgeInsets.all(
                          8), // Padding inside the container
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: green,
                            width: .2), // Grey border for each item
                        borderRadius: BorderRadius.circular(
                            8), // Optional: rounded corners
                      ),

                      child: ExplorePageMainTile(
                        media: media,
                        mainImage: post.image,
                        profileImage: post.userId.profilePic,
                        userName: post.userId.userName,
                        postTime: formatDate(post.createdAt),
                        description: post.description,
                        likeCount: post.likes.length.toString(),
                        commentCount: '',
                        index: index + startIndex, // Adjusted for original
                        removeSaved: () async {},
                        statesaved: state,
                        likeButtonPressed: () {},
                        commentButtonPressed: () {
                          context.read<GetCommentsBloc>().add(
                              CommentsFetchEvent(
                                  postId: state.posts[index].id.toString()));

                          AddComment(
                            profilePic: state
                                .posts[index + startIndex].userId.profilePic,
                            userName:
                                state.posts[index + startIndex].userId.userName,
                            comments: _comments,
                            id: state.posts[index + startIndex].userId.id,
                            onCommentAdded: () {
                              context
                                  .read<CommentCountBloc>()
                                  .add(IncrementCommentCount());
                            },
                            onCommentDeleted: () {
                              context
                                  .read<CommentCountBloc>()
                                  .add(DecrementCommentCount());
                            },
                          );

                          context.read<GetCommentsBloc>().add(
                              CommentsFetchEvent(
                                  postId: state.posts[index + startIndex].id
                                      .toString()));
                        },
                        commentes: _comments,
                      ),
                    );
                  },
                );
              } else {
                return errorStateWidget('No data found', greyMeduim);
              }
            } else if (state is ExplorerpostLoadingState) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: grey300!,
                  highlightColor: grey100!,
                  child: shimmerWidget1(media),
                ),
              );
            } else {
              return errorStateWidget(
                  'something went wrong try refreshing', greyMeduim);
            }
          },
        ),
      ),
    );
  }
}
