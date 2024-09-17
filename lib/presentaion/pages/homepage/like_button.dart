import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';

import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatefulWidget {
  final String postId;
  

  CustomLikeButton({super.key, required this.postId});

  @override
  State<CustomLikeButton> createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
      listener: (context, state) {
        if (state is LikePostSuccessfullState) {
          _isLiked = true;
        } else if (state is LikePostErrorState)
        
        
         {  print("likebutton pressed  ${widget.postId}");   
          _isLiked = false;
        }
      },
      child: LikeButton(
        circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Colors.white,
          dotSecondaryColor: Colors.white,
        ),
        likeBuilder: (bool isLiked) {
  print("likebutton pressed  ${widget.postId}");        return Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.white,
            size: 30,
          );
        },
        onTap: (isLiked) async {
          if (isLiked) {
            // Unlike post
          } else {
            context.read<LikeUnlikeBloc>().add(onUserLikeButtonPressedEvent(postId: widget.postId));
          }
        },
      ),
    );
  }
}