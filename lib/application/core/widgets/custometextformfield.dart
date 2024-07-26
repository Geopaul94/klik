import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;

  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
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
      ),
      validator: validator,
    );
  }
}
