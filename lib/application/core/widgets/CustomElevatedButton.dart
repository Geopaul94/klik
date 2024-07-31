import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double? height;
  final double? width;


  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 24.0,
    this.fontSize = 16.0,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // Define the button's height and width based on MediaQuery if not provided
    final buttonHeight = height ?? screenHeight * 0.08; // 8% of screen height
    final buttonWidth = width ?? screenWidth * 0.8; // 80% of screen width

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
