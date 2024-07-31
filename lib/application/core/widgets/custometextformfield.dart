// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final String labelText;

//   final IconData icon;
//   final TextEditingController controller;
//   final bool obscureText;
//   final FormFieldValidator<String>? validator;
//   final String? hintText;
//   final TextInputType keyboardType;

//   CustomTextFormField({
//     super.key,
//     required this.labelText,
//     required this.icon,
//     required this.controller,
//     this.obscureText = false,
//     this.validator,
//     this.hintText,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.green),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//       validator: validator,
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final Color errorTextColor;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final Color errorBorderColor; // Color for the error border
  final Color focusedErrorBorderColor; // Color for the focused error border
  final TextStyle? errorTextStyle; // Style for the error text
  final Color labelTextColor;
  final Color hintTextColor; // Color for the label text

  final String? errorText;
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorBorderColor = Colors.red, // Default error border color
    this.focusedErrorBorderColor =
        Colors.green, // Default focused error border color
    this.errorTextStyle, // Default error text style
    this.errorText,
    this.labelTextColor = Colors.grey,
    this.hintTextColor = Colors.grey, // Default label text color
    this.errorTextColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),

        errorStyle: TextStyle(color: errorTextColor),
        hintText: hintText,
        labelStyle:
            TextStyle(color: labelTextColor), // Set label text color here
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedErrorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validator != null
            ? null
            : "", // Display error text if there's a validator
      ),
      validator: validator,
    );
  }
}
