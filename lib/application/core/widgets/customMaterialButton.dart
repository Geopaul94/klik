import 'package:flutter/material.dart';

Widget customMaterialButton({
  required VoidCallback onPressed,
  required String text,
  required Color color,
  required double width,
  required double height,
  required double borderRadius,
  TextStyle textStyle = const TextStyle(color: Colors.white,fontSize: 20),
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minWidth: width,
    height: height,
    child: Text(
      text,
      style: textStyle,
    ),
  );
}
