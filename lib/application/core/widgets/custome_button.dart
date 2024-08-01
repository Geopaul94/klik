import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
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

MaterialButton loadingButton(
    {required Size media,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: green,
      size: 40,
    )),
  );
}
