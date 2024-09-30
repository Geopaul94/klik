import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/domain/model/followers_post_model.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';

import 'package:like_button/like_button.dart';






class CustomLikeButton extends StatefulWidget {
  final String postId;
  final List  likes; 
  final String userId; 

  CustomLikeButton({super.key, required this.postId, required this.likes, required this.userId});

  @override
  State<CustomLikeButton> createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton> {
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();

    // Check if the current user ID is in the list of likes
    // _isLiked = widget.likes.any((user) => user.id == widget.userId);
        _isLiked = widget.likes.any((user) {
          print('User ID from likes: ${user.id}');
          print('Current User ID: ${widget.userId}');
          
          return user.id == currentUser;
        });


    
    print("  ===================${_isLiked}");

    // Set initial like count
    _likeCount = widget.likes.length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
      listener: (context, state) {
        if (state is LikePostSuccessfullState && state.postId == widget.postId) {
          setState(() {
            _isLiked = true;
            _likeCount++;
          });
        } else if (state is UnlikePostSuccessfullState && state.postId == widget.postId) {
          setState(() {
            _isLiked = false;
            _likeCount--;
          });
        } else if (state is LikePostErrorState || state is UnlikePostErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error liking/unliking post')),
          );
        }
      },
      child: Row(
        children: [
          LikeButton(
            isLiked: _isLiked, // Use the _isLiked flag to determine the initial state
            likeBuilder: (bool isLiked) {
              return Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border, // Show red heart if liked
                color: _isLiked ? Colors.red : Colors.white,
                size: 30,
              );
            },
            onTap: (isLiked) async {
              // Check if the user has already liked the post by checking the list of likedUserIds
              if (_isLiked) {
                // If the user is already in the list, trigger the Unlike action
                context.read<LikeUnlikeBloc>().add(onUserUnlikeButtonPressedEvent(postId: widget.postId));
              } else {
                // If the user is not in the list, trigger the Like action
                context.read<LikeUnlikeBloc>().add(onUserLikeButtonPressedEvent(postId: widget.postId));
              }
              // Toggle like state (return opposite of current state)
              return !_isLiked;
            },
          ),
          SizedBox(width: 8),
          Text(_likeCount.toString(), style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
