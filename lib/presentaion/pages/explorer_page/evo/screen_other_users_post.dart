
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';
import 'package:klik/domain/model/postmodel.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/user_profileScreen.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
class PostDetailsUserPage extends StatefulWidget {
  final int initialindex;
  final List<Post> posts;

  const PostDetailsUserPage({
    super.key,
    required this.initialindex,
    required this.posts,
  });

  @override
  State<PostDetailsUserPage> createState() => _PostDetailsUserPageState();
}

class _PostDetailsUserPageState extends State<PostDetailsUserPage> {
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;
  final List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    // Initialize the scroll controller
    _scrollController = ScrollController(
      initialScrollOffset: widget.initialindex * 550,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    commentController.dispose();
    super.dispose();
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = widget.posts[index];
          final user = post.userId;
          final formattedDate = formatDate(post.date .toString());

          // Dispatch the event only if necessary (can optimize to prevent unnecessary re-fetching)
          context.read<GetCommentsBloc>().add(CommentsFetchEvent(postId: post.id));

          return SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user.profilePic ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return loadingAnimationWidget();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final searchedUser = UserIdSearchModel(
                                id: user.id,
                                userName: user.userName,
                                email: user.email,
                                profilePic: user.profilePic,
                                online: user.online,
                                blocked: user.blocked,
                                verified: user.verified,
                                role: user.role,
                                isPrivate: user.isPrivate,
                                backGroundImage: user.backGroundImage,
                                createdAt: user.createdAt,
                                updatedAt: user.updatedAt,
                                v: user.v,
                                bio: post.description,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileScreen(
                                    userId: user.id,
                                    user: searchedUser,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              user.userName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: width * 0.84,
                  width: width,
                  child: CachedNetworkImage(
                    imageUrl: post.image ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return LoadingAnimationWidget.hexagonDots(
                        color: Colors.green,
                        size: 30,
                      );
                    },
                  ),
                ),
                MultiBlocConsumer(
                  buildWhen: (previousState, currentState) => true,
                  blocs: [
                    context.watch<LikeUnlikeBloc>(),
                    context.watch<SaveUnsaveBloc>(),
                  ],
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (!post.likes.contains(currentUser)) {
                              post.likes.add(currentUser.toString());
                              context.read<LikeUnlikeBloc>().add(
                                    onUserLikeButtonPressedEvent(
                                      postId: post.id,
                                    ),
                                  );
                            } else {
                              post.likes.remove(currentUser);
                              context.read<LikeUnlikeBloc>().add(
                                    onUserUnlikeButtonPressedEvent(
                                      postId: post.id,
                                    ),
                                  );
                            }
                          },
                          icon: Icon(
                            post.likes.contains(currentUser)
                                ? Iconsax.heart5
                                : Iconsax.heart4,
                            color: post.likes.contains(currentUser) ? Colors.red : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.bubble_left,
                            color: Colors.white,
                            size: height * 0.03,
                          ),
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (context) => AddComment(
                                profilePic: user.profilePic ?? '',
                                userName: user.userName ?? '',
                                comments: _comments,
                                id: post.id,
                                onCommentAdded: () {
                                  context.read<CommentCountBloc>().add(IncrementCommentCount());
                                },
                                onCommentDeleted: () {
                                  context.read<CommentCountBloc>().add(DecrementCommentCount());
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
