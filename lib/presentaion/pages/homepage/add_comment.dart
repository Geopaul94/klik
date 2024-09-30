import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/comment_bloc/comment_post/comment_post_bloc.dart';
import 'package:klik/presentaion/bloc/comment_bloc/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
import 'package:intl/intl.dart';



class AddComment extends StatefulWidget {
  final String profilePic;
  final String userName;
  final List<Comment> comments;
  final String id;
 final VoidCallback onCommentAdded;
  final VoidCallback onCommentDeleted;
  const AddComment({
    super.key,
    required this.profilePic,
    required this.userName,
    required this.comments,
    required this.id, required this.onCommentAdded, required this.onCommentDeleted,
  });

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch comments when the widget is initialized
    context.read<GetCommentsBloc>().add(CommentsFetchEvent(postId: widget.id));
  }

  @override
  void dispose() {
    _commentController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
       
        backgroundColor: black,
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeleteCommentBloc, DeleteCommentState>(
              listener: (context, state) async {
                if (state is DeleteCommentLoadingState) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                    barrierDismissible: false,
                  );
                } else if (state is DeleteCommentSuccesfulState) {
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
                 

                  context
                      .read<GetCommentsBloc>()
                      .add(CommentsFetchEvent(postId: widget.id));
                  customSnackbar(context, "Comment Deleted Successfully", green);
                } else if (state is DeleteCommentServerErrorState) {
                  Navigator.of(context).pop();
                  customSnackbar(context, "Server error occurred!", red);
                }
              },
            ),
            BlocListener<CommentPostBloc, CommentPostState>(
              listener: (context, state) {
                if (state is CommentPostSuccesfulState) {
                  customSnackbar(context, "Comment Posted Successfully", green);
       widget.            onCommentAdded();
                  context
                      .read<GetCommentsBloc>()
                      .add(CommentsFetchEvent(postId: widget.id));

                  _commentController.clear();
                  FocusScope.of(context).unfocus();
                } else if (state is CommentPostErrorState) {
                  customSnackbar(context, "Error posting comment", red);
                }
              },
            ),
          ],
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<GetCommentsBloc, GetCommentsState>(
                  listener: (context, state) {
                    if (state is GetCommentsServerErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is GetCommentsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetCommentsSuccsfulState) {
                      return state.comments.isEmpty
                          ? const Center(
                              child: Text("No Comments",
                                  style: TextStyle(color: Colors.white)),
                            )
                          : ListView.builder(
                              itemCount: state.comments.length,
                              itemBuilder: (context, index) {
                                final comment = state.comments[
                                    state.comments.length - 1 - index];

                                return Card(
                                  color: Colors.grey[850],
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          comment.user.profilePic.isNotEmpty
                                              ? NetworkImage(
                                                  comment.user.profilePic)
                                              : const AssetImage(
                                                      'assets/g_logo.png')
                                                  as ImageProvider,
                                    ),
                                    title: Text(
                                      comment.user.userName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.content,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          DateFormat('dd MM yyyy')
                                              .format(comment.createdAt),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: currentUser == comment.user.id
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              final currentUser =
                                                  await getUserId();
                                              if (currentUser ==
                                                  comment.user.id) {
                                                bool? confirmDelete =
                                                    await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Delete Comment'),
                                                      content: const Text(
                                                          'Are you sure you want to delete this comment?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {

 widget. onCommentDeleted(); 

                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                if (confirmDelete == true) {
                                                  context
                                                      .read<
                                                          DeleteCommentBloc>()
                                                      .add(
                                                          DeleteCommentButtonClickEvent(
                                                              commentId:
                                                                  comment.id));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'You can only delete your own comments'),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : null, // Hide delete icon for other users
                                  ),
                                );
                              },
                            );
                    } else {
                      return const Center(
                          child: Text("No Comments",
                              style: TextStyle(color: Colors.white)));
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[850],
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.profilePic),
                      radius: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Type a comment...',
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a comment';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CommentPostBloc>().add(
                                    CommentPostButtonClickEvent(
                                      userName: widget.userName,
                                      postId: widget.id,
                                      content: _commentController.text,
                                    ),
                                  );

                              FocusScope.of(context).unfocus();
                              _commentController.clear();
                            }
                          },
                        ),
                        // Add comment count next to the send button
                       
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
     ) );
  }
}


// class AddComment extends StatefulWidget {
//   final String profilePic;
//   final String userName;
//   final List<Comment> comments;
//   final String id;
//  final VoidCallback onCommentAdded;
//   final VoidCallback onCommentDeleted;
//   const AddComment({
//     super.key,
//     required this.profilePic,
//     required this.userName,
//     required this.comments,
//     required this.id, required this.onCommentAdded, required this.onCommentDeleted,
//   });

//   @override
//   _AddCommentState createState() => _AddCommentState();
// }

// class _AddCommentState extends State<AddComment> {
//   final _formKey = GlobalKey<FormState>();
//   final _commentController = TextEditingController();
//   int _commentCount = 0;
//   String? currentUserId;

//   @override
//   void initState() {
//     super.initState();
//     _commentCount = widget.comments.length;
//     _fetchCurrentUserId(); // Fetch current user ID when the widget initializes
//     context.read<GetCommentsBloc>().add(CommentsFetchEvent(postId: widget.id));
//   }

//   Future<void> _fetchCurrentUserId() async {
//     final userId = await getUserId();
//     setState(() {
//       currentUserId = userId;
//     });
//   }

//   @override
//   void dispose() {
//     _commentController.dispose(); 
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//     );
//   }
// }
