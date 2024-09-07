import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/all_posts_model.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/domain/model/login_user_details_model.dart';
import 'package:klik/domain/model/my_post_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/comment_post_bloc/comment_post_bloc.dart';
import 'package:klik/presentaion/bloc/delete_comment_bloc/delete_comment_bloc.dart';

import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/screen_update_user_post.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
String logginedUserToken = '';
String logginedUserId = '';

class MyPostsScreen extends StatefulWidget {
  final int index;
  final List<MyPostModel> post;

  MyPostsScreen({super.key, required this.index, required this.post});
  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
  getToken() async {
    logginedUserToken = (await getUsertoken())!;
    logginedUserId = (await getUserId())!;
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 16, 16),
      appBar: CustomeAppbarRow(
        height: height,
        width: width,
        title: 'My Posts',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        gradientColors: [blue, green],
        backgroundColor: black,
        iconColor: Colors.white,
      ),
      body: BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
        builder: (context, state) {
          if (state is FetchMyPostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchMyPostSuccesState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(widget.index * 535);
              }
            });

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Myposts_card(
                  post: post,
                  index: index,
                );
              },
            );
          } else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No posts found.'));
          }
        },
      ),
    );
  }
}

class Myposts_card extends StatelessWidget {
  final MyPostModel post;

  final int index;
  Myposts_card({required this.post, required this.index});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  } TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

AllPostsModel? logginedUserdetails;

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
              profileImageUrl: post.userId!.profilePic.toString(),
              userName: post.userId!.userName.toString(),
              date: _formatDate(post.updatedAt),
              onIconTap: (TapDownDetails details) {
                showPopupMenu(
                    context, details.globalPosition, post.id.toString());
              },
              imageRadius: width * 0.08,
              userNameColor: Colors.white,
              dateColor: Colors.grey,
              userNameFontSize: 18.0,
              dateFontSize: 14.0,
            ),

            const SizedBox(height: 20),

            // Post image
            if (post.image!.isNotEmpty)
              Container(
                width: double.infinity,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(post.image.toString()),
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
                post.description.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: Colors.red,
                        size: height * 0.03,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.bubble_left,
                        color: Colors.white,
                        size: height * 0.03,
                      ),
                      onPressed: () {
                    
                    
 context.read<GetCommentsBloc>().add(
                                            CommentsFetchEvent(
                                                postId: post.id.toString()));
                                        commentBottomSheet(
                                            context, post, commentController,
                                            formkey: _formkey,
                                            userName: loginuserinfo.userName,
                                            profiePic: loginuserinfo.profilePic
                                                .toString(),
                                            comments: _comments,
                                            id: post.id.toString());




                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.bookmark,
                    color: Colors.white,
                    size: height * 0.03,
                  ),
                  onPressed: () {
                    // Save button pressed
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showPopupMenu(BuildContext context, Offset tapPosition, String postId) {
    showMenu(
      surfaceTintColor: Colors.black,
      shadowColor: Colors.black,
      color: darkgreymain,
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx + 10,
        tapPosition.dy + 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: const [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'edit') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenUpdateUserPost(
              model: post,
            ),
          ),
        );
      } else if (value == 'delete') {
        showDialog(
            context: context,
            builder: (context) {
              return BlocListener<FetchMyPostBloc, FetchMyPostState>(
                  listener: (context, state) {
                    if (state is OnDeleteButtonClickedLoadingState) {
                      // Show loading indicator, if needed
                    } else if (state is OnDeleteButtonClickedSuccesState) {
                      customSnackbar(context, "Your Post Deleted Successfully",
                          Colors.green);
                      Navigator.of(context).pop();
                    } else if (state is OnDeleteButtonClickedErrrorState) {
                      customSnackbar(context, state.error, Colors.red);
                    }
                  },
                  child: alertDialogueBox(context));
            });
      }
    });
  }

  AlertDialog alertDialogueBox(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 26, 24, 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      title: const Text(
        "Delete confirmation",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      content: const Text(
        "Are you sure you want to delete this post? It will not recover again!",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () {
            context.read<FetchMyPostBloc>().add(
                  OnMyPostDeleteButtonPressedEvent(postId: post.id.toString()),
                );

            context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());

            Navigator.of(context).pop();
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}




Future<dynamic> commentBottomSheet(
    BuildContext context, post, TextEditingController commentController,
    {required GlobalKey<FormState> formkey,
    required String profiePic,
    required String userName,
    required List<Comment> comments,
    required String id}) {
  return showModalBottomSheet(
    backgroundColor:
        Theme.of(context).brightness == Brightness.light ? white : darkgreymain,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              ProfileCircleTile(profilepic: profiePic),
              w10,
              Expanded(
                  child: Form(
                key: formkey,
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<DeleteCommentBloc, DeleteCommentState>(
                      listener: (context, state) {
                        if (state is DeleteCommentSuccesfulState) {
                          comments.removeWhere(
                              (comment) => comment.id == state.commentId);
                        }
                      },
                    ),
                    BlocListener<CommentPostBloc, CommentPostState>(
                      listener: (context, state) {
                        if (state is CommentPostSuccesfulState) {
                          Comment newComment = Comment(
                            id: state.commentId,
                            content: commentController.text,
                            createdAt: DateTime.now(),
                            user: CommentUser(
                              id: loginuserinfo.id,
                              userName: loginuserinfo.userName,
                              profilePic: loginuserinfo.profilePic,
                            ),
                          );
                          comments.add(newComment);
                          commentController.clear();
                        }
                      },
                    ),
                  ],
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(7),
                      hintText: 'write a comment....',
                      suffix: TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<CommentPostBloc>().add(
                                  CommentPostButtonClickEvent(
                                      userName: loginuserinfo.userName,
                                      postId: id,
                                      content: commentController.text),
                                );
                          }
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: green),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Write comment';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              )),
            ],
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.415,
            child: MultiBlocBuilder(
                blocs: [
                  context.watch<GetCommentsBloc>(),
                  // context.watch<DeleteCommentBloc>(),
                  context.watch<CommentPostBloc>(),
                ],
                builder: (context, states) {
                  if (states[0] is GetCommentsSuccessState) {
                    comments = states[0].comments;
                    return comments.isEmpty
                        ? const Center(
                            child: Text('no comments yet.'),
                          )
                        : ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              Comment comment = comments[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage:
                                        NetworkImage(loginuserinfo.profilePic),
                                  ),
                                  w10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 5,
                                          comment.user.userName,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          maxLines: 100,
                                          comment.content,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        // Text
                                        // timeago.format(comment.createdAt,
                                        //       locale: 'en_short'),
                                        //   style: const TextStyle(
                                        //       fontSize: 12, color: grey),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  w10,
                                  // if (loginuserinfo.id == comment.user.id)
                                    GestureDetector(
                                      onTap: () {
                                        // confirmationDialog(context,
                                        //     title: 'Delete this comment?',
                                        //     content:
                                        //         'Are you sure you want to delete this comment',
                                        //     onpressed: () {
                                        //   Navigator.pop(context);
                                        //   context.read<DeleteCommentBloc>().add(
                                        //       DeleteCommentButtonClickEvent(
                                        //           commentId: comment.id));
                                        // });
                                      },
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        color: red,
                                        size: 22,
                                      ),
                                    )
                                ],
                              );
                            });
                  } else if (states[0] is GetCommentsLoadingState) {
                    return Container();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    ),
  );
}



class ProfileCircleTile extends StatelessWidget {
  const ProfileCircleTile({
    super.key,
    required this.profilepic,
  });

  final String profilepic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: profilepic,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Container();
          },
        ),
      ),
    );
  }
}
String useridprofilescreen = '';
String profilepic = '';
String usernameprofile = '';
LoginUserModel loginuserinfo = LoginUserModel(
    id: 'id',
    userName: 'userName',
    email: 'email',
    phone: 'phone',
    online: false,
    blocked: false,
    verified: false,
    role: 'role',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    profilePic:
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png',
    backGroundImage:
        'https://img.freepik.com/free-vector/copy-space-bokeh-spring-lights-background_52683-55649.jpg');
UserModelPost userinfopost = UserModelPost(
    id: 'id',
    userName: 'userName',
    email: 'email',
    profilePic:
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png',
    backGroundImage:
        'https://img.freepik.com/free-vector/copy-space-bokeh-spring-lights-background_52683-55649.jpg',
    phone: 'phone',
    online: false,
    blocked: false,
    verified: false,
    role: 'role',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    v: 1);
    class UserModelPost {
  String id;
  String userName;
  String email;
  String? password;
  String profilePic;
  String backGroundImage;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? bio;
  String? name;
  UserModelPost({
    required this.id,
    required this.userName,
    required this.email,
    this.password,
    required this.profilePic,
    required this.backGroundImage,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.bio,
    this.name,
  });

  factory UserModelPost.fromJson(Map<String, dynamic> json) => UserModelPost(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        backGroundImage: json["backGroundImage"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        role: json["role"],
        isPrivate: json["isPrivate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "backGroundImage": backGroundImage,
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "role": role,
        "isPrivate": isPrivate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
      };
}
