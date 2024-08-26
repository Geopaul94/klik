
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:klik/application/core/constants/constants.dart';
// import 'package:klik/domain/model/comment_model.dart';
// import 'package:klik/presentaion/bloc/get_comments_bloc/get_comments_bloc.dart';
// import 'package:klik/presentaion/pages/profile_page/profile_page.dart';
// import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

// import 'package:timeago/timeago.dart' as timeago;

// Future<dynamic> commentBottomSheet(
//     BuildContext context, post, TextEditingController commentController,
//     {required GlobalKey<FormState> formkey,
//     required List<Comment> comments,
//     required String id}) {
//   return showModalBottomSheet(
// //     backgroundColor: kwhiteColor,
//     context: context,
//     builder: (context) => Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(logginedUserProfileImage),
//                 backgroundColor: grey,
//                 radius: 25,
//               ),
//               kwidth,
//               Expanded(
//                   child: Form(
//                 key: formkey,
//                 child: MultiBlocListener(
//                   listeners: [
//                     BlocListener<DeleteCommentBloc, DeleteCommentState>(
//                       listener: (context, state) {
//                         if (state is DeleteCommentSuccesfulState) {
//                           context
//                               .read<AllFollowersPostsBloc>()
//                               .add(AllFollowersPostsInitialFetchEvent());
//                           comments.removeWhere(
//                               (comment) => comment.id == state.commentId);
//                         }
//                       },
//                     ),
//                     BlocListener<CommentPostBloc, CommentPostState>(
//                       listener: (context, state) {
//                         if (state is CommentPostSuccesfulState) {
//                           Comment newComment = Comment(
//                             id: state.commentId,
//                             content: commentController.text,
//                             createdAt: DateTime.now(),
//                             user: CommentUser(
//                               id: logginedUserId,
//                               userName: profileuserName,
//                               profilePic: logginedUserProfileImage,
//                             ),
//                           );
//                           comments.add(newComment);
//                           commentController.clear();
//                         }
//                       },
//                     ),
//                   ],
//                   child: TextFormField(
//                     controller: commentController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(7),
//                       hintText: 'write a comment....',
//                       suffix: TextButton(
//                         onPressed: () {
//                           if (formkey.currentState!.validate()) {
//                             context.read<CommentPostBloc>().add(
//                                   CommentPostButtonClickEvent(
//                                       userName: profileuserName,
//                                       postId: id,
//                                       content: commentController.text),
//                                 );
//                             context
//                                 .read<AllFollowersPostsBloc>()
//                                 .add(AllFollowersPostsInitialFetchEvent());
//                           }
//                         },
//                         child: const Text(
//                           'Post',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Write comment';
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//               )),
//             ],
//           ),
//           const Divider(),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.415,
//             child: MultiBlocBuilder(
//                 blocs: [
//                   context.watch<GetCommentsBloc>(),
//                   context.watch<DeleteCommentBloc>(),
//                   context.watch<CommentPostBloc>(),
//                 ],
//                 builder: (context, states) {
//                   if (states[0] is GetCommentsSuccsfulState) {
//                     comments = states[0].comments;
//                     return comments.isEmpty
//                         ? const Center(
//                             child: Text('no comments yet.'),
//                           )
//                         : ListView.builder(
//                             itemCount: comments.length,
//                             itemBuilder: (context, index) {
//                               Comment comment = comments[index];
//                               return Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 18,
//                                     backgroundImage:
//                                         NetworkImage(comment.user.profilePic),
//                                   ),
//                                   kwidth,
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           maxLines: 5,
//                                           comment.user.userName,
//                                           style: const TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                               overflow: TextOverflow.ellipsis),
//                                         ),
//                                         Text(
//                                           maxLines: 100,
//                                           comment.content,
//                                           style: const TextStyle(
//                                               fontSize: 15,
//                                               overflow: TextOverflow.ellipsis),
//                                         ),
//                                         Text(
//                                           timeago.format(comment.createdAt,
//                                               locale: 'en_short'),
//                                           style: const TextStyle(
//                                               fontSize: 12, color: grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   kwidth,
//                                   if (logginedUserId == comment.user.id)
//                                     GestureDetector(
//                                       onTap: () {
//                                         confirmationDialog(context,
//                                             title: 'Delete',
//                                             content:
//                                                 'Are you sure want to Delete comment ?',
//                                             onpressed: () {
//                                           Navigator.pop(context);

//                                           context.read<DeleteCommentBloc>().add(
//                                               DeleteCommentButtonClickEvent(
//                                                   commentId: comment.id));
//                                         });
//                                       },
//                                       child: const Icon(
//                                         Icons.delete_rounded,
//                                         color: grey,
//                                         size: 22,
//                                       ),
//                                     )
//                                 ],
//                               );
//                             });
//                   } else if (states[0] is GetCommentsLoadingState) {
//                     return shimmerLoadingcomments(context);
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 }),
//           )
//         ],
//       ),
//     ),
//   );
// }
