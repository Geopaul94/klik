
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';

// class Customesavedpostbutton extends StatefulWidget {
//   final SavedPostModel post;
//   final String currentUserId;

//   const Customesavedpostbutton({
//     Key? key,
//     required this.post,
//     required this.currentUserId,
//   }) : super(key: key);

//   @override
//   State<Customesavedpostbutton> createState() => _Customesavedpostbutton();
// }

// class _Customesavedpostbutton extends State<Customesavedpostbutton> {
//   late bool saved;


//   @override
//   void initState() {
//     super.initState();
//     saved = widget.post.postId.likes.contains(widget.currentUserId);
   
//     print("Is saved ========================: $saved");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
//       listener: (context, state) {
//         if (state is SavePostSuccessfullState ) {
//           setState(() {
//             saved = true;
//             context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
//           });
//         } else if (state is RemoveSavedPostSuccessfulState ) {
//           setState(() {
//             saved = false;
//               context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
          
//           });
//         } else if (state is LikePostErrorState || state is UnlikePostErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Error liking/unliking post')),
//           );
//         }
//       },
//       child: Row(
//         children: [
//           LikeButton(
//             isLiked: saved,
//             likeBuilder: (bool isLiked) {
//               return Icon(
//                 saved ? Icons.favorite : Icons.bookmark,
//                 color: saved ? Colors.blue : Colors.white,
//                 size: 30,
//               );
//             },
//             onTap: (isLiked) async {
//               if (saved) {
//                 context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.post.postId.id));
//               } else {
//                 context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(postId: widget.post.postId.id));
//               }
//               return !saved;
//             },
//           ),
//           const SizedBox(width: 8),
//          // Text(_likeCount.toString(), style: const TextStyle(color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }

class Customesavedpostbutton extends StatefulWidget {
  final SavedPostModel post;
  final String currentUserId;

  const Customesavedpostbutton({
    super.key,
    required this.post,
    required this.currentUserId,
  });

  @override
  State createState() => _Customesavedpostbutton();
}

class _Customesavedpostbutton extends State<Customesavedpostbutton> {
  late bool saved;

  @override
  void initState() {
    super.initState();
    // Initially set saved to false
    

    // Fetch saved posts and check if currentUserId is in any of them
    final state = context.read<FetchSavedPostsBloc>().state;
    if (state is FetchSavedPostsSuccesfulState) {
      // Filter user IDs from fetched posts
      List<String> savedUserIds = state.posts.map((savedPost) => savedPost.userId).toList();

      // Check if currentUserId exists in the filtered list
      saved = savedUserIds.contains(widget.currentUserId);
    }

    print("Is saved ========================: $saved");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
      listener: (context, state) {
        if (state is SavePostSuccessfullState) {
          setState(() {
            saved = true; // Post is now saved
            context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
          });
        } else if (state is RemoveSavedPostSuccessfulState) {
          setState(() {
            saved = false; // Post is now unsaved
            context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
          });
        } else if (state is SavePostErrorState || state is RemoveSavedPostErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error saving/unsaving post')),
          );
        }
      },
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              saved ? Icons.bookmark : Icons.bookmark_border,
              color: saved ? Colors.blue : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              if (saved) {
                context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(postId: widget.post.postId.id)); context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
              } else {
                context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.post.postId.id)); context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
