import 'package:flutter/material.dart';
import 'dart:async';

class TypewriterGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final Duration speed;

  const TypewriterGradientText({
    required this.text,
    required this.style,
    required this.gradient,
    this.speed = const Duration(milliseconds: 100),
  });

  @override
  _TypewriterGradientTextState createState() => _TypewriterGradientTextState();
}

class _TypewriterGradientTextState extends State<TypewriterGradientText>
    with SingleTickerProviderStateMixin {
  String _displayedText = '';
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      setState(() {
        _displayedText = widget.text.substring(0, _currentIndex + 1);
        _currentIndex++;
        if (_currentIndex == widget.text.length) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return widget.gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        _displayedText,
        style: widget.style.copyWith(color: Colors.white),
      ),
    );
  }
}
