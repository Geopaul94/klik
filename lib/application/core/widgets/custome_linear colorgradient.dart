// import 'package:flutter/material.dart';

// class CustomeLinearcolor extends StatelessWidget {
//   final String text;
//   final double? fontSize;
//   final FontWeight fontWeight;
//   final TextAlign textAlign;
//   final TextDecoration textDecoration;
//   final List<Color>? gradientColors;
//   final IconData? iconData;
//   final Gradient? gradient;  final double? size;

//   CustomeLinearcolor({
//     required this.text,
//     this.fontSize,
//     this.fontWeight = FontWeight.normal,
//     this.textAlign = TextAlign.left,
//     this.textDecoration = TextDecoration.none,
//     this.gradientColors,
//     this.iconData,this.gradient,this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double defaultFontSize = 16.0;

//     final TextStyle textStyle = TextStyle(
//       fontSize: fontSize ?? defaultFontSize,
//       fontWeight: fontWeight,
//       decoration: textDecoration,
//     );

//     if (gradientColors != null) {
//       return ShaderMask(
//         shaderCallback: (bounds) {
//           return LinearGradient(
//             colors: gradientColors!,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ).createShader(bounds);
//         },
//         child: Text(
//           text,
//           style: textStyle.copyWith(color: Colors.white), // Base color
//           textAlign: textAlign,
//         ),
//       );
//     } else {
//       return Text(
//         text,
//         style: textStyle,
//         textAlign: textAlign,
//       );
//     }
//   }
// }








import 'package:flutter/material.dart';

class CustomeLinearcolor extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final List<Color>? gradientColors;
  final IconData? iconData;
  final double? iconSize;
  final List<Color>? iconGradientColors;

  CustomeLinearcolor({
    this.text,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.gradientColors,
    this.iconData,
    this.iconSize,
    this.iconGradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final double defaultFontSize = 16.0;
    final double defaultIconSize = 24.0;

    final TextStyle textStyle = TextStyle(
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight,
      decoration: textDecoration,
    );

    Widget? gradientText;
    Widget? gradientIcon;

    if (text != null && gradientColors != null) {
      gradientText = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: gradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: Text(
          text!,
          style: textStyle.copyWith(color: Colors.white),
          textAlign: textAlign,
        ),
      );
    } else if (text != null) {
      gradientText = Text(
        text!,
        style: textStyle,
        textAlign: textAlign,
      );
    }

    if (iconData != null && iconGradientColors != null) {
      gradientIcon = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: iconGradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: Icon(
          iconData,
          size: iconSize ?? defaultIconSize,
          color: Colors.white,
        ),
      );
    } else if (iconData != null) {
      gradientIcon = Icon(
        iconData,
        size: iconSize ?? defaultIconSize,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (gradientText != null) gradientText,
        if (gradientText != null && gradientIcon != null)
          SizedBox(width: 8.0), // Spacing between text and icon
        if (gradientIcon != null) gradientIcon,
      ],
    );
  }
}
