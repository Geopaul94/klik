// // ignore: file_names
// import 'package:flutter/material.dart';

// class CustomElevatedButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color color;
//   final Color textColor;
//   final double borderRadius;
//   final double elevation;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   final double height;
//   final double width;

//   CustomElevatedButton({
//     required this.text,
//     required this.onPressed,
//     this.color = Colors.green,
//     this.textColor = Colors.white,
//     this.borderRadius = 8.0,
//     this.elevation = 2.0,
//     this.paddingVertical = 12.0,
//     this.paddingHorizontal = 24.0,
//     required this.height,
//     required this.width,
//   });

//   @override
//   Widget build(BuildContext context) {

//         final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: textColor,
//         backgroundColor: color,
//         elevation: elevation,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: paddingVertical,
//           horizontal: paddingHorizontal,
//         ),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }
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
  final double? heightFactor;
  final double? widthFactor;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 24.0,
    this.heightFactor,
    this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonHeight =
        heightFactor != null ? size.height * heightFactor! : 50.0;
    final buttonWidth = widthFactor != null ? size.width * widthFactor! : 150.0;

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
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
