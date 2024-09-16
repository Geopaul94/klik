import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/presentaion/bloc/comment_bloc/comment_post/comment_post_bloc.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/pages/profile_page/profile_page.dart';

class AddComment extends StatefulWidget {
  final String profilePic;
  final String userName;
  final List<Comment> comments;
  final String id;

  const AddComment({
    super.key,
    required this.profilePic,
    required this.userName,
    required this.comments,
    required this.id,
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: black,
        body: BlocConsumer<GetCommentsBloc, GetCommentsState>(
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
              return Column(
                children: [
                  Expanded(
                    child: state.comments.isEmpty
                        ? const Center(
                            child: Text("No Comments",
                                style: TextStyle(color: Colors.white)),
                          )
                        : ListView.builder(
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) {
                              final comment = state
                                  .comments[state.comments.length - 1 - index];
                              return Card(
                                color: Colors.grey[850],
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: comment
                                            .user.profilePic.isNotEmpty
                                        ? NetworkImage(comment.user.profilePic)
                                        : const AssetImage('assets/g_logo.png')
                                            as ImageProvider, // Default image
                                  ),
                                  title: Text(
                                    comment.user.userName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    comment.content,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  // The comment input form at the bottom
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width:
                              50, // Set the width and height to create a circular shape
                          height: 50,
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Make the container circular
                            image: DecorationImage(
                              image: NetworkImage(widget.profilePic),
                              fit: BoxFit
                                  .cover, // Scale the image to fit the container
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Type a comment...',
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
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                            icon: const Icon(Icons.arrow_upward),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint('Username: ${userdetails.userName}');

                                context.read<CommentPostBloc>().add(
                                      CommentPostButtonClickEvent(
                                        userName: widget.userName.toString(),
                                        postId: widget.id,
                                        content: _commentController.text,
                                      ),
                                    );

                                _commentController
                                    .clear(); // Clear the text field after submission

                                FocusScope.of(context)
                                    .unfocus(); // Dismiss the keyboard
                              } else {
                                // Handle the case when userName is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Username is required'), // Corrected semicolon
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is GetCommentsServerErrorState) {
              return Center(
                child: Text('Error: ${state.error}',
                    style: const TextStyle(color: Colors.red)),
              );
            }

            return const SizedBox
                .shrink(); // Empty widget in case no state matches
          },
        ),
      ),
    );
  }
}