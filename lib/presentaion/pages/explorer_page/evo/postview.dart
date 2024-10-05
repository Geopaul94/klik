import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/explore_users_user_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/evo/user_profileScreen.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/like_button.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:klik/presentaion/pages/profile_page/profilesession_pages/profile_succes_dummy_container.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:readmore/readmore.dart';


final _formkey = GlobalKey<FormState>();
List<Comment> _comments = [];
final commentController = TextEditingController();

class PostView extends StatelessWidget {
  final String description;
  final String profilePic;
  final String userName;
  final int v;
  final String image;
  final List likes;
  final post;
  final String email;
  final bool online;
  final bool verified;
  final String role;
  final bool isPrivate;
  final DateTime createdAt;
  final String background;
  final String bio;
  final DateTime edited;
  final String id;
  final String userId;
  final bool saved;
  final List<SavedPostModel>? posts;
  final bool? hidden;
  final DateTime creartedAt;
  final DateTime updatedAt;
  final List? taggedUsers;
  final bool blocked;
  final DateTime? date;
  final List<String>? tags;

  const PostView({
    super.key,
    required this.post,
    required this.image,
    required this.likes,
    required this.description,
    required this.id,
    required this.userId,
    required this.saved,
    this.posts,
    this.hidden,
    required this.creartedAt,
    required this.updatedAt,
    this.taggedUsers,
    required this.blocked,
    this.date,
    this.tags,
    required this.profilePic,
    required this.userName,
    required this.edited,
    required this.v,
    required this.email,
    required this.online,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.background,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    return Align(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  profileContainer(size, profilePic, background),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final user = UserIdSearchModel(
                            id: id,
                            userName: userName,
                            email: email,
                            profilePic: profilePic,
                            online: online,
                            blocked: blocked,
                            verified: verified,
                            role: role,
                            isPrivate: isPrivate,
                            backGroundImage: background,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            v: v,
                            bio: bio,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                userId: userId,
                                user: user,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Text(
                        _formatDate(createdAt),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * .84,
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiBlocConsumer(
                buildWhen: null,
                blocs: [
                  context.watch<LikeUnlikeBloc>(),
                  context.watch<SaveUnsaveBloc>(),
                ],
                listener: (context, state) {},
                builder: (context, states) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              CustomLikeButton(
                                postId: id,
                                likes: likes,
                                userId: userId,
                              );
                            },
                            child: const Icon(Icons.favorite),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
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
                                      profilePic: profilePic,
                                      userName: userName,
                                      comments: _comments,
                                      id: id,
                                      onCommentAdded: () {
                                        context.read<CommentCountBloc>().add(
                                            IncrementCommentCount());
                                      },
                                      onCommentDeleted: () {
                                        context.read<CommentCountBloc>().add(
                                            DecrementCommentCount());
                                      },
                                    ),
                                  );
                                },
                              ),
                              Text(
                                _comments.length.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          posts != null
                              ? GestureDetector(
                                  onTap: () {
                                    if (posts!.any(
                                        (element) => element.postId.id == id)) {
                                      context.read<SaveUnsaveBloc>().add(
                                          OnUserRemoveSavedPost(postId: id));
                                      posts!.removeWhere(
                                          (element) => element.postId.id == id);
                                    } else {
                                      posts!.add(SavedPostModel(
                                          userId: userId,
                                          postId: PostId(
                                              id: id,
                                              userId: UserIdSavedPost.fromJson(
                                                  userdetails.toJson()),
                                              image: image,
                                              description: description,
                                              likes: [],
                                              hidden: hidden!,
                                              blocked: blocked,
                                              tags: tags!,
                                              date: date!,
                                              createdAt: creartedAt,
                                              updatedAt: updatedAt,
                                              v: 0,
                                              taggedUsers: taggedUsers!),
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          v: 0));
                                      context.read<SaveUnsaveBloc>().add(
                                          OnUserSavePost(postId: id));
                                    }
                                  },
                                  child: Icon(
                                    posts!.any((element) =>
                                            element.postId.id == id)
                                        ? CupertinoIcons.bookmark_fill
                                        : CupertinoIcons.bookmark,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      likes.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  text: '${likes.length} ',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: 'likes',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: const TextSpan(
                                  text: '0 ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'likes',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 10),
                        child: ReadMoreText(
                          description,
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          colorClickableText: Colors.blue,
                          trimCollapsedText: ' more.',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          lessStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          trimExpandedText: ' show less',
                          moreStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }
}
