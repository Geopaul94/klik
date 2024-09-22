import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/all_posts_model.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/login_user_details_model.dart';
import 'package:klik/domain/model/save_post_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/get_followers_post_bloc/getfollowers_post_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/like_button.dart';
import 'package:klik/presentaion/pages/homepage/save_removesave.dart';
import 'package:klik/presentaion/pages/homepage/suggession_page.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';




String? currentUser; 



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;
   List<String> userIds = [];


  @override
  void initState() {
    super.initState();
    context
        .read<GetfollowersPostBloc>()
        .add(FetchFollowersPostEvent(page: _page));
        context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
        
        
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: appBar(context),
    //   // backgroundColor: Colors.black,
    //   body: BlocBuilder<GetfollowersPostBloc, GetfollowersPostState>(
    //     buildWhen: (previous, current) {
    //       return current is GetfollowersPostLoadingState ||
    //           current is GetfollowersPostSuccessState ||
    //           current is GetfollowersPostErrorState;
    //     },
    //     builder: (context, state) {
    //       if (state is GetfollowersPostLoadingState) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is GetfollowersPostSuccessState) {
    //         context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    //         if (state.HomePagePosts.isEmpty) {
    //           return const Center(
    //             child: Text(
    //               "Please follow your friends in the suggestion page",
    //               style: TextStyle(color: Colors.white, fontSize: 16),
    //             ),
    //           );
    //         }
            
    //         else{
    //           return MultiBlocListener(
    //             listeners: [
    //               BlocListener<FetchSavedPostsBloc, FetchSavedPostsState>(
    //                 listener: (context, savedpoststate) {
    //                 if (savedpoststate is   FetchSavedPostsSuccesfulState) {
                      


    //                   List<SavedPostModel>savedPosts=savedpoststate .posts;

    //                   print('Saved posts fetched successfully: $savedPosts');
    //                 }else if (savedpoststate is FetchSavedPostsErrorState){


    //                   customSnackbar(context, 'Error fetching saved posts: ${savedpoststate.error}', red);
    //                 }
    //                 },
    //               ),
    //               BlocListener<SubjectBloc, SubjectState>(
    //                 listener: (context, state) {
    //                   // TODO: implement listener
    //                 },
    //               ),
    //             ],














    //             child: ListView.builder(
    //             itemCount: state.HomePagePosts.length,
    //             itemBuilder: (context, index) {
    //               final post = state.HomePagePosts[index];
    //               return HomPage_card(HomePagePosts: post);
    //             },
    //           );
    //         }
    //       } else if (state is GetfollowersPostErrorState) {
    //         return Center(child: Text('Error: ${state.error}'));
    //       } else {
    //         return const Center(child: Text('No posts available'));
    //       }
              
            
            
            
            
            
            
            
           
    //     },
    //   ),
    // );









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
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetfollowersPostSuccessState) {
        context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
        if (state.HomePagePosts.isEmpty) {
          return const Center(
            child: Text(
              "Please follow your friends in the suggestion page",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else {
          return MultiBlocListener(
            listeners: [
              BlocListener<FetchSavedPostsBloc, FetchSavedPostsState>(
                listener: (context, savedpoststate) {
                  if (savedpoststate is FetchSavedPostsSuccesfulState) {
                    List<SavedPostModel> savedPosts = savedpoststate.posts;
                    print('Saved posts fetched successfully ===========: $savedPosts');



  List<String> userIds = savedPosts.map((post) => post.userId).toList();

        // Print the list of userIds
        print('User IDs from saved posts  ++++++: $userIds');

                  } else if (savedpoststate is FetchSavedPostsErrorState) {
                    customSnackbar(context, 'Error fetching saved posts: ${savedpoststate.error}', red);
                  }
                },
              ),
              
            ],
            child: ListView.builder(
              itemCount: state.HomePagePosts.length,
              itemBuilder: (context, index) {
                final post = state.HomePagePosts[index];
                return HomPage_card(HomePagePosts: post, userIds:userIds );
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
          CustomeLinearcolor(
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
  final AllPostsModel HomePagePosts;
 final List<String>userIds;




   HomPage_card({super.key, required this.HomePagePosts, required this.userIds, });

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

    context
        .read<GetCommentsBloc>()
        .add(CommentsFetchEvent(postId: widget.HomePagePosts.id));
  }

  @override
  Widget build(BuildContext context) {

   //   final createdAt = DateTime.parse(widget.HomePagePosts.createdAt.toString());
   // final editedTime = DateTime.parse(widget.HomePagePosts.editedTime.toString());

    // bool isEdited =
    //     !areDateTimesEqualIgnoringMilliseconds(createdAt, editedTime);
    final width = MediaQuery.of(context).size.width;
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
                    image: NetworkImage(widget.HomePagePosts.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.HomePagePosts.description ?? 'No description available',
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

  row_Bottom_icons(double height, BuildContext context) {
    return

//     MultiBlocBuilder(
//   blocs: [
//     context.watch<LikeUnlikeBloc>(),
//     context.watch<FetchSavedPostsBloc>(),
//     context.watch<SaveUnsaveBloc>(),
//   ],
//   builder: (context, states) {
//     var state2 = states[1];
//     if (state2 is FetchSavedPostsSuccesfulState) {
//       posts = state2.posts;
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//            IconButton(
//   onPressed: () {
//     final currentUserId = widget.HomePagePosts.userId?.id;
//     final isLiked = widget.HomePagePosts.likes.any((user) => user.id == currentUserId);
//     if (!isLiked) {
//       final newUser = User(
//         id: currentUserId!,
//         userName: widget.HomePagePosts.userId?.userName ?? '',
//         email: '', // You need to provide the email of the current user
//         profilePic: widget.HomePagePosts.userId?.profilePic ?? '',
//       );
//       widget.HomePagePosts.likes.add(newUser);

//       context.read<LikeUnlikeBloc>().add(onUserLikeButtonPressedEvent(postId: widget.HomePagePosts.id.toString()));
//     } else {
//       widget.HomePagePosts.likes.removeWhere((user) => user.id == currentUserId);
//       context.read<LikeUnlikeBloc>().add(onUserUnlikeButtonPressedEvent(postId: widget.HomePagePosts.id.toString()));
//     }
//   },
//   icon: Icon(
//     widget.HomePagePosts.likes.any((user) => user.id == widget.HomePagePosts.userId?.id) ? Iconsax.heart5 : Iconsax.heart4,
//     color: widget.HomePagePosts.likes.any((user) => user.id == widget.HomePagePosts.userId?.id) ? red : null,
//   ),
// )
        // IconButton(
        //   onPressed: () {
        //     context.read<GetCommentsBloc>().add(CommentsFetchEvent(postId: post.id.toString()));

        //     commentBottomSheet(
        //       context,
        //       post,
        //       commentController,
        //       formkey: _formkey,
        //       userName: loginuserinfo.userName,
        //       profiePic: loginuserinfo.profilePic.toString(),
        //       comments: _comments,
        //       id: post.id.toString(),
        //     );
        //   },
        //   icon: const Icon(
        //     Iconsax.message4,
        //     size: 25,
        //   ),
        // ),
        //   ],
        // ),
        // IconButton(
        //   onPressed: () {
        //     if (posts.any((element) => element.postId.id == post.id)) {
        //       context.read<SavedPostBloc>().add(RemoveSavedPostButtonClickEvent(postId: post.id.toString()));
        //       posts.removeWhere((element) => element.postId.id == post.id);
        //     } else {
        //       posts.add(SavedPostModel(
        //         userId: post.userId.id.toString(),
        //         postId: PostId(
        //           id: post.id.toString(),
        //           userId: UserIdSavedPost.fromJson(post.userId.toJson()),
        //           image: post.image.toString(),
        //           description: post.description.toString(),
        //           likes: post.likes,
        //           hidden: post.hidden,
        //           blocked: post.blocked,
        //           tags: post.tags,
        //           date: post.date,
        //           createdAt: post.createdAt,
        //           updatedAt: post.updatedAt,
        //           v: post.v,
        //           taggedUsers: post.taggedUsers,
        //         ),
        //         createdAt: DateTime.now(),
        //         updatedAt: DateTime.now(),
        //         v: post.v,
        //       ));
        //       if (kDebugMode) {
        //         print(posts);
        //       }
        //       context.read<SavedPostBloc>().add(SavePostButtonClickEvent(postId: post.id.toString()));
        //       context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
        //     }
        //   },
        //   icon: Icon(
        //     posts.any((element) => element.postId.id == post.id) ? Icons.bookmark : Icons.bookmark_border,
        //     color: posts.any((element) => element.postId.id == post.id) ? buttonclr : grey,
        //     size: 25,
        //   ),
        // ),
//       ],
//     );
//   },
// );

        Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                CustomLikeButton(
                  postId: widget.HomePagePosts.id,
                  likes: widget.HomePagePosts.likes,
                  userId: userdetails.id,
                     // Ensure you're passing the actual userId
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.bubble_left,
                    color: Colors.white,
                    size: height * 0.03,
                  ),
                  onPressed: () async {
                    // Assuming you have the data ready

                    String userName =
                        widget.HomePagePosts.userId!.userName.toString();
                    String profilePic =
                        widget.HomePagePosts.userId!.profilePic.toString();
                    ;
                    // String id =comments.id;
                    debugPrint(profilePic);
                    // Now pass these values to the AddComment widget
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => AddComment(
                        profilePic: profilePic,
                        userName: userName,
                        comments: comments,
                        id: widget.HomePagePosts.id,
                      ),
                    );
                  },
                ),
                Text(widget.HomePagePosts.commentCount.toString()),
              ],
            ),
          ],
        ),
        

        // SavePostButton(
        //   postId: widget.HomePagePosts.id, 
        
        //    currentUserId: currentUser.toString(),  userIds:widget.userIds,

           
        // )



// MultiBlocBuilder(blocs: [  context.watch<FetchSavedPostsBloc>(),
//             context.watch<SaveUnsaveBloc>(),],
            
//              builder: (context ,state){
//               var state2 =state[1];
//               if (state2 is FetchSavedPostsSuccesfulState) {
//                 posts=state2.posts;
//               }

//               return Row(
                
//                 children:[


// IconButton(
//                     onPressed: () {
//                       if (posts
//                           .any((element) => element.postId.id == widget.HomePagePosts.id)) {
//                         context.read<SaveUnsaveBloc>().add(
//                             OnUserRemoveSavedPost(
//                                 postId: widget.HomePagePosts.id.toString()));
//                         posts.removeWhere(
//                             (element) => element.postId.id == widget.HomePagePosts.id);
//                       } else {
//                         posts.add(SavedPostModel(
//                             userId: widget.HomePagePosts.userId!.id.toString(),
//                             postId: PostId(
//                                 id: widget.HomePagePosts.id.toString(),
//                                 userId: UserIdSavedPost.fromJson(
//                                     widget.HomePagePosts.userId!.toJson()),
//                                 image: widget.HomePagePosts.image.toString(),
//                                 description: widget.HomePagePosts.description.toString(),
//                                 likes: widget.HomePagePosts.likes,
//                                 hidden: widget.HomePagePosts.hidden,
//                                 blocked: widget.HomePagePosts.blocked,
//                                 tags: widget.HomePagePosts.tags,
//                                 date: widget.HomePagePosts.date,
//                                 createdAt: widget.HomePagePosts.createdAt,
//                                 updatedAt: widget.HomePagePosts.updatedAt,
//                                 v: widget.HomePagePosts.v,
//                                 taggedUsers: widget.HomePagePosts.taggedUsers),
//                             createdAt: DateTime.now(),
//                             updatedAt: DateTime.now(),
//                             v: widget.HomePagePosts.v));
//                         context.read<SaveUnsaveBloc>().add(
//                             OnUserSavePost(
//                                 postId: widget.HomePagePosts.id.toString()));
//                       }
//                     },
//                     icon: Icon(
//                       posts.any((element) => element.postId.id == widget.HomePagePosts.id)
//                           ? Icons.bookmark
//                           : Icons.bookmark_border,
//                       color: customIconColor,
//                       size: 25,
//                     ))

//                 ]);
//              }
            
            
            
            
            
            
//             )











      ],
    );
  }

  Row nameAndDateRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            widget.HomePagePosts.userId?.profilePic ?? '',
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.HomePagePosts.userId?.userName ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatDate(widget.HomePagePosts.date),
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

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _page = 1;
//   List<SavedPostModel> posts = [];
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<GetfollowersPostBloc>()
//         .add(FetchFollowersPostEvent(page: _page));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: BlocBuilder<GetfollowersPostBloc, GetfollowersPostState>(
//         buildWhen: (previous, current) {
//           return current is GetfollowersPostLoadingState ||
//               current is GetfollowersPostSuccessState ||
//               current is GetfollowersPostErrorState;
//         },
//         builder: (context, state) {
//           return _buildBody(state);
//         },
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: black,
//       automaticallyImplyLeading: false,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset('assets/croped_headline.png', height: 30),
//           CustomeLinearcolor(
//             text: "Share Moments",
//             gradientColors: [green, blue],
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                 CupertinoPageRoute(
//                   builder: (context) => const SuggessionPage(),
//                   fullscreenDialog: true,
//                 ),
//               );
//             },
//             child: const Icon(
//               CupertinoIcons.person_add_solid,
//               color: grey,
//               size: 30,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody(GetfollowersPostState state) {
//     if (state is GetfollowersPostLoadingState) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is GetfollowersPostSuccessState) {
//       return _buildPostList(state);
//     } else if (state is GetfollowersPostErrorState) {
//       return Center(child: Text('Error: ${state.error}'));
//     } else {
//       return const Center(child: Text('No posts available'));
//     }
//   }

//   Widget _buildPostList(GetfollowersPostSuccessState state) {
//     if (state.HomePagePosts.isEmpty) {
//       return const Center(
//         child: Text(
//           "Please follow your friends in the suggestion page",
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: state.HomePagePosts.length,
//       itemBuilder: (context, index) {
//         final post = state.HomePagePosts[index];
//         return HomePageCard(post: post);
//       },
//     );
//   }
// }

// class HomePageCard extends StatefulWidget {
//   final AllPostsModel post;

//   const HomePageCard({required this.post});

//   @override
//   State<HomePageCard> createState() => _HomePageCardState();
// }

// class _HomePageCardState extends State<HomePageCard> {
//   bool _isSaved = false;
//   List<SavedPostModel> posts = [];
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<GetCommentsBloc>()
//         .add(CommentsFetchEvent(postId: widget.post.id));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Card(
//       color: Colors.black,
//       margin: const EdgeInsets.all(8.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             const SizedBox(height: 20),
//             _buildImage(height),
//             const SizedBox(height: 10),
//             _buildDescription(),
//             _buildBottomIcons(context, height),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 25,
//           backgroundImage: NetworkImage(
//             widget.post.userId?.profilePic ?? '',
//           ),
//         ),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.post.userId?.userName ?? '',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               _formatDate(widget.post.date),
//               style: const TextStyle(color: grey, fontSize: 14),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildImage(double height) {
//     if (widget.post.image.isNotEmpty) {
//       return Container(
//         width: double.infinity,
//         height: height * 0.4,
//         decoration: BoxDecoration(
//           color: Colors.grey[900],
//           borderRadius: BorderRadius.circular(15),
//           image: DecorationImage(
//             image: NetworkImage(widget.post.image),
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     }
//     return Container();
//   }

//   Widget _buildDescription() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         widget.post.description ?? 'No description available',
//         style: const TextStyle(fontSize: 16, color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildBottomIcons(BuildContext context, double height) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             CustomLikeButton(
//               postId: widget.post.id,
//               likes: widget.post.likes,
//               userId: widget.post.userId.toString(),
//             ),
//             const SizedBox(width: 10),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     CupertinoIcons.bubble_left,
//                     color: Colors.white,
//                     size: height * 0.03,
//                   ),
//                   onPressed: _openCommentModal,
//                 ),
//                 Text(widget.post.commentCount.toString()),
//               ],
//             ),
//           ],
//         ),
//         IconButton(
//           icon: Icon(
//             _isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
//             color: _isSaved ? Colors.blue : Colors.white,
//             size: height * 0.03,
//           ),
//           onPressed: _toggleSave,
//         ),
//       ],
//     );
//   }

//   void _toggleSave() {
//     setState(() {
//       _isSaved = !_isSaved;
//     });
//   }

//   void _openCommentModal() async {
//     await showModalBottomSheet(
//       context: context,
//       builder: (context) => AddComment(
//         profilePic: widget.post.userId?.profilePic ?? '',
//         userName: widget.post.userId?.userName ?? '',
//         comments: [],
//         id: widget.post.id,
//       ),
//     );
//   }

//   String _formatDate(DateTime? date) {
//     if (date == null) return 'Unknown date';
//     return DateFormat('dd MMMM yyyy').format(date.toLocal());
//   }
// }
