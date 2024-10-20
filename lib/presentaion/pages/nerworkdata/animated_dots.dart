import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _dotCount = IntTween(begin: 0, end: 3).animate(_controller); // Animating between 0 and 3 dots
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,  // Remove yellow color background
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          String dots = '.' * (_dotCount.value + 1);  // Animating dots only
          
          return Text.rich(
            TextSpan(
              text: 'Trying to connect',  // Static text
              children: [
                TextSpan(
                  text: dots,  // Animated dots
                ),
              ],
            ),
            style: const TextStyle(
              color: darkgreymain,  // Use a valid color, replace `darkgreymain` with `Colors.grey` if needed
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          );
        },
      ),
    );
  }
}
