import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/domain/model/save_post_model.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';

class SavePostButton extends StatefulWidget {
  bool? saved;
  final String postId;
  final String userId;

  SavePostButton({
    super.key,
    required this.postId,
    required this.userId,
  });

  @override
  _SavePostButtonState createState() => _SavePostButtonState();
}

class _SavePostButtonState extends State<SavePostButton> {
  late bool saved = false;
  late List<SavedPostModel> posts;

  @override
  void initState() {
    super.initState();
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
  }

  void _toggleSave() {
    // Toggle between save and remove based on current saved state
    if (saved) {
      context
          .read<SaveUnsaveBloc>()
          .add(OnUserRemoveSavedPost(postId: widget.postId));
    } else {
      context.read<SaveUnsaveBloc>().add(OnUserSavePost(postId: widget.postId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocListener<SaveUnsaveBloc, SaveUnsaveState>(
      listener: (context, state) {
        if (state is SavePostSuccessfullState &&
            state.post.id == widget.postId) {
          // Post saved successfully, update UI and notify parent
          setState(() {
            saved = true;
        
          });
          saved;
        } else if (state is RemoveSavedPostSuccessfulState) {
          // Post removed from saved, update UI and notify parent
          setState(() {
            saved = false;
          });
          saved;
        } else if (state is SavePostErrorState ||
            state is RemoveSavedPostErrorState) {
          // Handle error (show error message, Snackbar, etc.)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state is SavePostErrorState
                ? state.error
                : (state as RemoveSavedPostErrorState).error),
          ));
        }
      },
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
