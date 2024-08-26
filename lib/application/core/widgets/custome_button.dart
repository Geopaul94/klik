import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';


MaterialButton customButton(
    {required Size media,
    required String buttonText,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Text(buttonText),
  );
}
MaterialButton loadingButton({
  required Size media,
  required VoidCallback onPressed,
  required Color gradientStartColor,
  required Color gradientEndColor,
  required Color loadingIndicatorColor,
  double? height, // Optional height parameter
  double? width,  // Optional width parameter
}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    minWidth: width ?? media.width, // Use the provided width or default to media width
    height: height ?? media.height * 0.06, // Use the provided height or default to media height * 0.06
    padding: EdgeInsets.zero,
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        alignment: Alignment.center,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: loadingIndicatorColor,
          size: 40,
        ),
      ),
    ),
  );

}