import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customeAppbar_row.dart';

import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/userPost_row_name_and_date.dart';
import 'package:klik/domain/model/followers_post_model.dart';
import 'package:klik/domain/model/comment_model.dart';

import 'package:klik/domain/model/my_post_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';

import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';

import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/my_post_delete_edit/screen_update_user_post.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

String logginedUserToken = '';
String logginedUserId = '';

class MyPostsScreen extends StatefulWidget {
  final int index;
  final List<MyPostModel> post;

  const MyPostsScreen({super.key, required this.index, required this.post});
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
        gradientColors: const [blue, green],
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
  Myposts_card({super.key, required this.post, required this.index});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  FollowersPostModel? logginedUserdetails;

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

            bottom_raw_card(height),
          ],
        ),
      ),
    );
  }

  Row bottom_raw_card(double height) {
    return Row(
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



                      
                    },
                  ),
                ],
              ),
              // IconButton(
              //   icon: Icon(
              //     CupertinoIcons.bookmark,
              //     color: Colors.white,
              //     size: height * 0.03,
              //   ),
              //   onPressed: () {
              //     // Save button pressed
              //   },
              // ),
            ],
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
