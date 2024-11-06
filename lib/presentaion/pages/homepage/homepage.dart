import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/domain/model/followers_post_model.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/domain/repository/user_repo/user_repo.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/get_followers_post_bloc/getfollowers_post_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/like_button.dart';
import 'package:klik/presentaion/pages/homepage/suggession_page.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:klik/services/socket/socket.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



String? commmentcount;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _page = 1;
  List<String> userIds = [];

  @override
  void initState() {
    super.initState();



    SocketService().connectSocket(context: context);
    context
        .read<GetfollowersPostBloc>()
        .add(FetchFollowersPostEvent(page: _page));
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());

   UserRepo.fetchUserPostsOther(userId: currentuserId);

    UserRepo.fetchUserPostsOther(userId: currentuserId);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocBuilder<GetfollowersPostBloc, GetfollowersPostState>(
        buildWhen: (previous, current) {
          return current is GetfollowersPostLoadingState ||
              current is GetfollowersPostSuccessState ||
              current is GetfollowersPostErrorState;
        },
        builder: (context, state) {
          if (state is GetfollowersPostLoadingState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LoadingAnimationWidget.hexagonDots(
                  color: green,
                  size: 50,
                ),
              ),
            );
          } else if (state is GetfollowersPostSuccessState) {
            context
                .read<FetchSavedPostsBloc>()
                .add(SavedPostsInitialFetchEvent());
            if (state.HomePagePosts.isEmpty) {
              return const Center(
                child: Text(
                  "Please follow your friends in the suggestion page",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            } else {
              return 
              MultiBlocListener(
                listeners: [
                  BlocListener<FetchSavedPostsBloc, FetchSavedPostsState>(
                    listener: (context, savedpoststate) {
                      if (savedpoststate is FetchSavedPostsSuccesfulState) {
                        List<SavedPostModel> savedPosts = savedpoststate.posts;

                     
                        savedPosts
                            .map((post) => post.userId)
                            .toList();

                     

                      } else if (savedpoststate is FetchSavedPostsErrorState) {
                        customSnackbar(
                            context,
                            'Error fetching saved posts: ${savedpoststate.error}',
                            red);
                      }
                    },
                  ),
                ],
                child: ListView.builder(
                  itemCount: state.HomePagePosts.length,
                  itemBuilder: (context, index) {
                    final post = state.HomePagePosts[index];
                    return HomPage_card(HomePagePosts: post, userIds: userIds);
                  },
                ),
              );
            }
          } else if (state is GetfollowersPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No posts available'));
          }
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/croped_headline.png',
            height: 30,
          ),
          const CustomeLinearcolor(
              text: "Share Moments", gradientColors: [green, blue]),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const SuggessionPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Icon(
              CupertinoIcons.person_add_solid,
              color: grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class HomPage_card extends StatefulWidget {
  final FollowersPostModel HomePagePosts;
  final List<String> userIds;

  const HomPage_card({
    super.key,
    required this.HomePagePosts,
    required this.userIds,
  });

  @override
  State<HomPage_card> createState() => _HomPage_cardState();
}

class _HomPage_cardState extends State<HomPage_card> {
  List<Comment> comments = [];
  List<SavedPostModel> posts = [];

  bool? _isSaved;
  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  @override
  void initState() {
    super.initState();

    commmentcount = widget.HomePagePosts.commentCount.toString();

    context
        .read<GetCommentsBloc>()
        .add(CommentsFetchEvent(postId: widget.HomePagePosts.id));
  }

  @override
  Widget build(BuildContext context) {
    DateTime.parse(widget.HomePagePosts.createdAt.toString());

    final height = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameAndDateRow(),
            const SizedBox(height: 20),
            if (widget.HomePagePosts.image.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.HomePagePosts.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.HomePagePosts.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            row_Bottom_icons(height, context),
          ],
        ),
      ),
    );
  }


  // row_Bottom_icons(double height, BuildContext context) {
  //   return MultiBlocBuilder(
  //     blocs: [
  //       context.watch<CommentPostBloc>(),
  //       context.watch<FetchSavedPostsBloc>(),
  //       context.watch<SaveUnsaveBloc>(),
  //       context.watch<LikeUnlikeBloc>(),
  //       context.watch<CommentCountBloc>(),
  //     ],
  //     builder: (context, states) {
  //       var state2 = states[1]; // FetchSavedPostsBloc state
  //       var commentCountState = states[4];
  //       if (state2 is FetchSavedPostsSuccesfulState) {
  //         posts = state2.posts;
  //       }

  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               // Custom Like Button

  //               CustomLikeButton(
  //                 postId: widget.HomePagePosts.id,
  //                 likes: widget.HomePagePosts.likes,
  //                 userId: userdetails.id,
  //               ),

  //               // Comment Section

  //               Row(
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(
  //                       CupertinoIcons.bubble_left,
  //                       color: Colors.white,
  //                       size: height * 0.03,
  //                     ),
  //                     onPressed: () async {
  //                       String userName =
  //                           widget.HomePagePosts.userId.userName.toString();
  //                       String profilePic =
  //                           widget.HomePagePosts.userId.profilePic.toString();

  //                       debugPrint(profilePic);

  //                       await showModalBottomSheet(
  //                         context: context,
  //                         builder: (context) => AddComment(
  //                           profilePic: profilePic,
  //                           userName: userName,
  //                           comments: comments,
  //                           id: widget.HomePagePosts.id,
  //                           onCommentAdded: () {
                          
  //                             context
  //                                 .read<CommentCountBloc>()
  //                                 .add(IncrementCommentCount());
  //                           },
  //                           onCommentDeleted: () {
                        
  //                             context
  //                                 .read<CommentCountBloc>()
  //                                 .add(DecrementCommentCount());
  //                           },
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                   Text(
  //                     (commentCountState is CommentCountState)
  //                         ? commentCountState.commentCount.toString()
  //                         : widget.HomePagePosts.  commentCount
  //                             .toString(), 
  //                     style: const TextStyle(color: Colors.white),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           saveIcon(context)







 Row row_Bottom_icons(double height, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomLikeButton(
              postId: widget.HomePagePosts.id,
              likes: widget.HomePagePosts.likes,
              userId: userdetails.id,
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.bubble_left,
                color: Colors.white,
                size: height * 0.03,
              ),
              onPressed: () async {
                String userName = widget.HomePagePosts.userId.userName.toString();
                String profilePic = widget.HomePagePosts.userId.profilePic.toString();

                await showModalBottomSheet(
                  context: context,
                  builder: (context) => AddComment(
                    profilePic: profilePic,
                    userName: userName,
                    comments: comments,
                    id: widget.HomePagePosts.id,
                    onCommentAdded: () {
                      setState(() {
                        widget.HomePagePosts.commentCount++; // Increment only for this post
                      });
                    },
                    onCommentDeleted: () {
                      setState(() {
                        widget.HomePagePosts.commentCount--; // Decrement only for this post
                      });
                    },
                  ),
                );
              },
            ),
            Text(
              widget.HomePagePosts.commentCount.toString(), // Use local comment count
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
       // saveIcon(context),





BlocBuilder<SaveUnsaveBloc, SaveUnsaveState>(
  builder: (context, state) {
    // Determine if the post is already saved based on the current Bloc state
    bool isAlreadySaved = posts.any(
      (element) => element.postId.id == widget.HomePagePosts.id,
    );

    if (state is SavePostSuccessfullState && state.post == widget.HomePagePosts.id) {
      isAlreadySaved = true;
    } else if (state is RemoveSavedPostSuccessfulState && state.post == widget.HomePagePosts.id) {
      isAlreadySaved = false;
    }

    return IconButton(
      onPressed: () async {
        if (isAlreadySaved) {
          // Dispatch the unsave event
          context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(
                postId: widget.HomePagePosts.id.toString(),
              ));
        } else {
          // Dispatch the save event
          context.read<SaveUnsaveBloc>().add(OnUserSavePost(
                postId: widget.HomePagePosts.id.toString(),
              ));
        }
      },
      icon: Icon(
        isAlreadySaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
        color: blue,
        size: 25,
      ),
    );
  },
)








          ],
        );
    //  },
   // );
  }

  // IconButton saveIcon(BuildContext context) {
  //   return IconButton(
  //     onPressed: () async {
  //       bool isAlreadySaved = posts.any(
  //         (element) => element.postId.id == widget.HomePagePosts.id,
  //       );

  //       if (isAlreadySaved) {
  //         context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(
  //               postId: widget.HomePagePosts.id.toString(),
  //             ));

  //         posts.removeWhere(
  //           (element) => element.postId.id == widget.HomePagePosts.id,
  //         );

  //         print("Post removed: ${widget.HomePagePosts.id}");
  //       } else {
  //         // If the post is not saved, add it to the saved list
  //         posts.add(SavedPostModel(
  //           userId: widget.HomePagePosts.userId.id.toString(),
  //           postId: PostId(
  //             id: widget.HomePagePosts.id.toString(),
  //             userId: UserIdSavedPost.fromJson(
  //                 widget.HomePagePosts.userId.toJson()),
  //             image: widget.HomePagePosts.image.toString(),
  //             description: widget.HomePagePosts.description.toString(),
  //             likes: widget.HomePagePosts.likes,
  //             hidden: widget.HomePagePosts.hidden,
  //             blocked: widget.HomePagePosts.blocked,
  //             tags: widget.HomePagePosts.tags,
  //             date: widget.HomePagePosts.createdAt,
  //             createdAt: widget.HomePagePosts.createdAt,
  //             updatedAt: widget.HomePagePosts.updatedAt,
  //             v: widget.HomePagePosts.v,
  //             taggedUsers: widget.HomePagePosts.taggedUsers,
  //           ),
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now(),
  //           v: widget.HomePagePosts.v,
  //         ));

  //         // Add the post to the backend
  //         context.read<SaveUnsaveBloc>().add(OnUserSavePost(
  //               postId: widget.HomePagePosts.id.toString(),
  //             ));
  //       }
  //     },
  //     icon: Icon(
  //       posts.any((element) => element.postId.id == widget.HomePagePosts.id)
  //           ? CupertinoIcons.bookmark_fill
  //           : CupertinoIcons.bookmark,
  //       color: blue,
  //       size: 25,
  //     ),
  //   );
  // }








  Row nameAndDateRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            widget.HomePagePosts.userId.profilePic,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.HomePagePosts.userId.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formatDate(widget.HomePagePosts.createdAt),
              style: const TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}










