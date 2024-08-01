import 'package:flutter/material.dart';

class CustomeLinearcolor extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final List<Color>? gradientColors;

  CustomeLinearcolor({
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final double defaultFontSize = 16.0;

    final TextStyle textStyle = TextStyle(
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight,
      decoration: textDecoration,
    );

    if (gradientColors != null) {
      return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: gradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Text(
          text,
          style: textStyle.copyWith(color: Colors.white), // Base color
          textAlign: textAlign,
        ),
      );
    } else {
      return Text(
        text,
        style: textStyle,
        textAlign: textAlign,
      );
    }
  }
}
