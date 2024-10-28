import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/domain/model/comment_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/commentcount_bloc/comment_count_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/imagedetailed_page.dart';
import 'package:klik/presentaion/pages/homepage/add_comment.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';

// class ExplorePageMainTile extends StatelessWidget {
//   const ExplorePageMainTile({
//     super.key,
//     required this.media,
//     required this.mainImage,
//     required this.profileImage,
//     required this.userName,
//     required this.postTime, // This is a String
//     required this.description,
//     required this.likeCount,
//     required this.commentCount,
//     required this.index,
//     required this.removeSaved,
//     required this.statesaved,
//     required this.likeButtonPressed,
//     required this.commentButtonPressed,
//     required this.commentes,
//   });

//   final String profileImage;
//   final String mainImage;
//   final String userName;
//   final String postTime; // This is a String, which we will convert to DateTime
//   final String description;
//   final String likeCount;
//   final String commentCount;
//   final VoidCallback likeButtonPressed;
//   final VoidCallback? commentButtonPressed;
//   final Future<void> Function() removeSaved;
//   final dynamic statesaved;
//   final Size media;
//   final int index;
//   final List<Comment> commentes;

//   // Helper function to format DateTime
//   String formatDate(DateTime dateTime) {
//     final DateFormat formatter =
//         DateFormat('MMM d, yyyy'); // Customize the format as needed
//     return formatter.format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final post = statesaved.posts[index];

//     // Print the postTime for debugging
//     print("Raw postTime: $postTime");

//     // Try to parse the postTime (ensure it's in a valid DateTime format)
//     DateTime? parsedPostTime = DateTime.tryParse(postTime);

//     // Print the result after parsing for debugging
//     print("Parsed postTime: $parsedPostTime");

//     ///  String formattedDate = formatDate(parsedPostTime);



// print("  comments length===========        ${commentes.length.toString()}");
// print(commentes);
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                   backgroundImage: NetworkImage(profileImage),
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       userName,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       postTime, // Display the formatted date
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             kheight,
//             kheight,
//             Container(
//               width: double.infinity,
//               height: height * 0.4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   image: NetworkImage(mainImage),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 description,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
//               builder: (context, state) {
//                 bool isLiked = post.likes.contains(currentuserId);
//                 int currentLikeCount = post.likes.length;

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 if (isLiked) {
//                                   context.read<LikeUnlikeBloc>().add(
//                                         onUserUnlikeButtonPressedEvent(
//                                             postId: post.id),
//                                       );

//                                   post.likes.remove(currentuserId);
//                                 } else {
//                                   context.read<LikeUnlikeBloc>().add(
//                                         onUserLikeButtonPressedEvent(
//                                             postId: post.id),
//                                       );

//                                   post.likes
//                                       .add(currentuserId);
//                                 }
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   isLiked
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: isLiked ? red : customIconColor,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               '$currentLikeCount ',
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: Icon(
//                                 CupertinoIcons.bubble_left,
//                                 color: Colors.white,
//                                 size: height * 0.03,
//                               ),
//                               onPressed: () async {
//                                 String profilePic = profileImage;

//                                 debugPrint(profilePic);

//                                 await showModalBottomSheet(
//                                   context: context,
//                                   builder: (context) => AddComment(
//                                     profilePic: profilePic,
//                                     userName: userName,
//                                     comments: commentes,
//                                     id: post.id,
//                                     onCommentAdded: () {
//                                       // Dispatch the increment event
//                                       context
//                                           .read<CommentCountBloc>()
//                                           .add(IncrementCommentCount());
//                                     },
//                                     onCommentDeleted: () {
//                                       // Dispatch the decrement event
//                                       context
//                                           .read<CommentCountBloc>()
//                                           .add(DecrementCommentCount());
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                             // Text(
//                             // commmentcount.toString(), 
//                             //   style: const TextStyle(color: Colors.white),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Import your image detail page here




class ExplorePageMainTile extends StatelessWidget {
  const ExplorePageMainTile({
    super.key,
    required this.media,
    required this.mainImage,
    required this.profileImage,
    required this.userName,
    required this.postTime, // This is a String
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.index,
    required this.removeSaved,
    required this.statesaved,
    required this.likeButtonPressed,
    required this.commentButtonPressed,
    required this.commentes,
  });

  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime; // This is a String, which we will convert to DateTime
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback? commentButtonPressed;
  final Future<void> Function() removeSaved;
  final dynamic statesaved;
  final Size media;
  final int index;
  final List<Comment> commentes;

  // Helper function to format DateTime
  String formatDate(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime != null) {
      final DateFormat formatter = DateFormat('MMM d, yyyy'); // Customize the format as needed
      return formatter.format(dateTime);
    }
    return dateTimeString; // Return original string if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final post = statesaved.posts[index];

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(profileImage),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatDate(postTime), // Display the formatted date
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(mainImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
              builder: (context, state) {
                bool isLiked = post.likes.contains(currentuserId);
                int currentLikeCount = post.likes.length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isLiked) {
                              context.read<LikeUnlikeBloc>().add(
                                    onUserUnlikeButtonPressedEvent(postId: post.id),
                                  );
                              post.likes.remove(currentuserId); // Update the local state
                            } else {
                              context.read<LikeUnlikeBloc>().add(
                                    onUserLikeButtonPressedEvent(postId: post.id),
                                  );
                              post.likes.add(currentuserId); // Update the local state
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white, // Use your custom color here
                            ),
                          ),
                        ),
                        Text(
                          '$currentLikeCount ',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                                profilePic: profileImage,
                                userName: userName,
                                comments: commentes,
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
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}