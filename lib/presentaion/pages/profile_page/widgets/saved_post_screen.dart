import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/postmodel.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/comment_bloc/comment_post/comment_post_bloc.dart';

import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/customesavelikebutton.dart';

class SavedPostScreen extends StatefulWidget {
  final int index;
  final List<SavedPostModel> posts;

  const SavedPostScreen({
    super.key,
    required this.index,
    required this.posts,
  });

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(widget.index * 535);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomeAppbarRow(
        height: size.height,
        width: size.width,
        title: 'Saved Posts',
        onBackButtonPressed: () => Navigator.pop(context),
        gradientColors: const [blue, green],
        backgroundColor: black,
        iconColor: Colors.white,
      ),
      body: BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
        builder: (context, state) {
          if (state is FetchSavedPostsSuccesfulState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return SavedPostsCard(
                  post: post,
                  index: index,
                  posts: state.posts,
                );
              },
            );
          }
          // Handle other states (loading, error, etc.)
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SavedPostsCard extends StatefulWidget {
  final SavedPostModel post;
  final int index;
  final List<SavedPostModel> posts; // Add the posts list here

  const SavedPostsCard(
      {super.key,
      required this.post,
      required this.index,
      required this.posts}); // Include posts

  @override
  State<SavedPostsCard> createState() => _SavedPostsCardState();
}

class _SavedPostsCardState extends State<SavedPostsCard> {
  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> comments = [];

  @override
  Widget build(BuildContext context) {
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
            UserRowWidget(
              showIcon: false,
              profileImageUrl: widget.post.postId.userId.profilePic,
              userName: widget.post.postId.userId.userName,
              date: _formatDate(widget.post.updatedAt),
              onIconTap: (TapDownDetails details) {},
              imageRadius: width * 0.08,
              userNameColor: Colors.white,
              dateColor: Colors.grey,
              userNameFontSize: 18.0,
              dateFontSize: 14.0,
            ),

            const SizedBox(height: 20),

            // Post image
            if (widget.post.postId.image.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.post.postId.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 2),
            const SizedBox(height: 10),

            // Post description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.post.postId.description.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Customesavelikebutton(
                    post: widget.post,
                    currentUserId: currentUser.toString(),
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
                          String userName = widget.post.postId.userId.userName;
                          String profilePic =
                              widget.post.postId.userId.profilePic;
                          debugPrint(profilePic);

                          await showModalBottomSheet(
                            context: context,
                            builder: (context) => AddComment(
                              profilePic: profilePic,
                              userName: userName,
                              comments: comments,
                              id: widget.post.postId.id,
                              onCommentAdded: () {},
                              onCommentDeleted: () {},
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ]),
                IconButton(
                  onPressed: () async {
                    bool isAlreadySaved = widget.posts.any(
                      (element) => element.postId.id == widget.post.postId.id,
                    );

                    if (isAlreadySaved) {
                      // Dispatch the event to remove the post
                      context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(
                            postId: widget.post.postId.id.toString(),
                          ));
                      context
                          .read<FetchSavedPostsBloc>()
                          .add(SavedPostsInitialFetchEvent());

                      // Remove the post locally
                      setState(() {
                        widget.posts.removeWhere(
                          (element) =>
                              element.postId.id == widget.post.postId.id,
                        ); context
                          .read<FetchSavedPostsBloc>()
                          .add(SavedPostsInitialFetchEvent());
                      });

                      print("Post removed: ${widget.post.postId.id}");
                    } else {
                      // Add the post locally
                      setState(() {
                        widget.posts.add(
                          SavedPostModel(
                            userId: widget.post.postId.userId.id.toString(),
                            postId: PostId(
                              id: widget.post.postId.id.toString(),
                              userId: UserIdSavedPost.fromJson(
                                widget.post.postId.userId.toJson(),
                              ),
                              image: widget.post.postId.image.toString(),
                              description:
                                  widget.post.postId.description.toString(),
                              likes: widget.post.postId.likes,
                              hidden: widget.post.postId.hidden,
                              blocked: widget.post.postId.blocked,
                              tags: widget.post.postId.tags,
                              date: widget.post.postId.createdAt,
                              createdAt: widget.post.postId.createdAt,
                              updatedAt: widget.post.postId.updatedAt,
                              v: widget.post.postId.v,
                              taggedUsers: widget.post.postId.taggedUsers,
                            ),
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            v: widget.post.postId.v,
                          ),
                        );
                      });

                      // Dispatch the event to save the post
                      context.read<SaveUnsaveBloc>().add(
                            OnUserSavePost(
                              postId: widget.post.postId.id.toString(),
                            ),
                          );
                    }
                  },
                  icon: Icon(
                    widget.posts.any(
                      (element) => element.postId.id == widget.post.postId.id,
                    )
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                    color: blue,
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
