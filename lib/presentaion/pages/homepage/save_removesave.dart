import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';




// List<SavePostModel>saveposts =[];



// class SavePostButton extends StatefulWidget {
//   bool? saved;
//   final String postId;
//   final String userId;

//   SavePostButton({
//     super.key,
//     required this.postId,
//     required this.userId,
//   });

//   @override
//   _SavePostButtonState createState() => _SavePostButtonState();
// }

// class _SavePostButtonState extends State<SavePostButton> {
//   late bool saved = false;
//   late List<SavedPostModel> posts;

//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
//   }

//   void _toggleSave() {
//     // Toggle between save and remove based on current saved state
//     if (saved) {
//       context
//           .read<SaveUnsaveBloc>()
//           .add(OnUserRemoveSavedPost(postId: widget.postId));
//     } else {
//       context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.postId));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
//       listener: (context, state) {
//         if (state is SavePostSuccessfullState &&
//             state.post.id == widget.postId) {
//           // Post saved successfully, update UI and notify parent
//           setState(() {
//             saved = true;
        
//           });
//           saved;
//         } else if (state is RemoveSavedPostSuccessfulState) {
//           // Post removed from saved, update UI and notify parent
//           setState(() {
//             saved = false;
//           });
//           saved;
//         } else if (state is SavePostErrorState ||
//             state is RemoveSavedPostErrorState) {
//           // Handle error (show error message, Snackbar, etc.)
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(state is SavePostErrorState
//                 ? state.error
//                 : (state as RemoveSavedPostErrorState).error),
//           ));
//         }
//       },
//       child: IconButton(
//         icon: Icon(
//           saved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
//           color: saved ? Colors.blue : Colors.white,
//           size: height * 0.03,
//         ),
//         onPressed: _toggleSave,
//       ),
//     );
//   }
// }



// List<SavePostModel> saveposts = []; // Global list to store saved posts

// class SavePostButton extends StatefulWidget {
//   bool? saved;
//   final String postId;
//   final String userId;
// final List<String>userIds;
//   SavePostButton({
//     super.key,
//     required this.postId,
//     required this.userId, required this.userIds,
//   });

//   @override
//   _SavePostButtonState createState() => _SavePostButtonState();
// }

// class _SavePostButtonState extends State<SavePostButton> {
//   late bool saved ;

//   @override
//   void initState() {
//     super.initState();
    

//       saved = widget.userIds.any((user) {
//           print('User ID from likes: ${user.id}');
//           print('Current User ID: ${widget.userId}');
          
//           return user.id == currentUser;
//         });


    
//     print("  ===================${saved}");

//     // Fetch the saved posts when the app starts
//     context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
//   }

//   void _toggleSave() {
//     // Toggle between save and remove based on current saved state
//     if (saved) {
//       context
//           .read<SaveUnsaveBloc>()
//           .add(OnUserRemoveSavedPost(postId: widget.postId));
//     } else {
//       context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.postId));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return MultiBlocListener(
//       listeners: [
//         BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
//           listener: (context, state) {
//             if (state is SavePostSuccessfullState &&
//                 state.post.id == widget.postId) {
//               // Post saved successfully, update UI
//               setState(() {
//                 saved = true;
//               });
//             } else if (state is RemoveSavedPostSuccessfulState 
//                     ) {
//               // Post removed from saved, update UI
//               setState(() {
//                 saved = false;
//               });
//             } else if (state is SavePostErrorState ||
//                 state is RemoveSavedPostErrorState) {
//               // Handle error (show error message, Snackbar, etc.)
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text(state is SavePostErrorState
//                     ? state.error
//                     : (state as RemoveSavedPostErrorState).error),
//               ));
//             }
//           },
//         ),
    
//       ],
//       child: IconButton(
//         icon: Icon(
//           saved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
//           color: saved ? Colors.blue : Colors.white,
//           size: height * 0.03,
//         ),
//         onPressed: _toggleSave,
//       ),
//     );
//   }
// }

    











    class SavePostButton extends StatefulWidget {
  final String postId;
  final String currentUserId; // Current user's ID
  final List<String> userIds; // List of user IDs who saved the post

  const SavePostButton({
    super.key,
    required this.postId,
    required this.currentUserId,
    required this.userIds,
  });

  @override
  _SavePostButtonState createState() => _SavePostButtonState();
}

class _SavePostButtonState extends State<SavePostButton> {
  late bool saved;

  @override
  void initState() {
    super.initState();
    

  saved =isCurrentUserInList(widget.userIds, widget.currentUserId);
  
  
   



    // Check if the current user exists in the list of userIds
    // saved = widget.userIds.contains(widget.currentUserId);

    print("Saved state initialized: $saved");

    // Fetch the saved posts when the app starts
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
  }

   bool isCurrentUserInList(List<String> userIds, String currentUserId) {
    for (String userId in userIds) {
      if (userId == currentUserId) {
        return true;
      }
    }
    return false;
  }


  void _toggleSave() async{
    // Toggle between save and remove based on the current saved state
    if (saved) {
      print("Post unsaved");
      setState(() {
        saved = false;  // Update the saved state before triggering the event
      });
      context.read<SaveUnsaveBloc>().add(OnUserRemoveSavedPost(postId: widget.postId));
    } else {
      print("Post saved");
      setState(() {
        saved = true;  // Update the saved state before triggering the event
      });
      context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.postId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return MultiBlocListener(
      listeners: [
        BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
          listener: (context, state) {
            if (state is SavePostSuccessfullState && state.post.id == widget.postId) {
              // Post saved successfully, update UI
              setState(() {
                saved = true;
                context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
              });
            } else if (state is RemoveSavedPostSuccessfulState && state.post.id == widget.postId) {
              // Post removed from saved, update UI
              setState(() {
                saved = false;
                context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
              });
            } else if (state is SavePostErrorState || state is RemoveSavedPostErrorState) {
              // Handle error (show error message, Snackbar, etc.)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state is SavePostErrorState
                    ? state.error
                    : (state as RemoveSavedPostErrorState).error),
              ));
            }
          },
        ),
      ],
      child: IconButton(
        icon: Icon(
          saved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
          color: saved ? Colors.blue : Colors.white,
          size: height * 0.03,
        ),
        onPressed: _toggleSave,
      ),
    );
  }
}
