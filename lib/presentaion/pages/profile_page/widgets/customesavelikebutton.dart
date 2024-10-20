import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:klik/domain/model/saved_post_model.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';

class Customesavelikebutton extends StatefulWidget {
  final SavedPostModel post;
  final String currentUserId;

  const Customesavelikebutton({
    super.key,
    required this.post,
    required this.currentUserId,
  });

  @override
  State<Customesavelikebutton> createState() => _Customesavelikebutton();
}

class _Customesavelikebutton extends State<Customesavelikebutton> {
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.postId.likes.contains(widget.currentUserId);
    _likeCount = widget.post.postId.likes.length;
    print("Is liked: $_isLiked");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
      listener: (context, state) {
        if (state is LikePostSuccessfullState && state.postId == widget.post.postId.id) {
          setState(() {
            _isLiked = true;
            _likeCount++;
          });
        } else if (state is UnlikePostSuccessfullState && state.postId == widget.post.postId.id) {
          setState(() {
            _isLiked = false;
            _likeCount--;
          });
        } else if (state is LikePostErrorState || state is UnlikePostErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error liking/unliking post')),
          );
        }
      },
      child: Row(
        children: [
          LikeButton(
            isLiked: _isLiked,
            likeBuilder: (bool isLiked) {
              return Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : Colors.white,
                size: 30,
              );
            },
            onTap: (isLiked) async {
              if (_isLiked) {
                context.read<LikeUnlikeBloc>().add(onUserUnlikeButtonPressedEvent(postId: widget.post.postId.id));
              } else {
                context.read<LikeUnlikeBloc>().add(onUserLikeButtonPressedEvent(postId: widget.post.postId.id));
              }
              return !_isLiked;
            },
          ),
          const SizedBox(width: 8),
          Text(_likeCount.toString(), style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}