import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

import 'package:flutter/material.dart';

class AnimatedContainerBorder extends StatefulWidget {
  const AnimatedContainerBorder({super.key});

  @override
  State<AnimatedContainerBorder> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainerBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> topLeftAnim;
  late Animation<Alignment> bottomRightAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    topLeftAnim = TweenSequence([
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
    ]).animate(_controller);

    bottomRightAnim = TweenSequence([
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween<Alignment>(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Container(
  decoration: BoxDecoration(
  
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: topLeftAnim.value,
      end: bottomRightAnim.value,
      colors: [Colors.red, Colors.blue],
    ),
  ),
  height: 300,
  width: 300,
),
            );
          },
        ),
      ),
    );
  }
}