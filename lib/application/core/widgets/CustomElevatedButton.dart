
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? fontSize;
  final double? height;
  final double? width;
    final FontWeight? fontWeight; 
    final Color? fontcolor;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.paddingVertical,
    this.paddingHorizontal,
    this.fontSize,
    this.height,
    this.width, this.fontWeight,this.fontcolor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // Define the button's height and width based on MediaQuery if not provided
    final buttonHeight = height ?? screenHeight * 0.08; // 8% of screen height
    final buttonWidth = width ?? screenWidth * 0.8; // 80% of screen width

    // Define default padding and font size if not provided
    final double defaultPaddingVertical = 10.0;
    final double defaultPaddingHorizontal = 16.0;
    final double defaultFontSize = 25.0;

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
            vertical: paddingVertical ?? defaultPaddingVertical,
            horizontal: paddingHorizontal ?? defaultPaddingHorizontal,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize ?? defaultFontSize  ,fontWeight: fontWeight,color:fontcolor),
        ),
      ),
    );
  }
}
