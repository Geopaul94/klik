import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;

  CustomText({
    required this.text,
    this.fontSize = 14.0,
    this.color = Colors.green,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
    );
  }
}





class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.icon,
      required this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.minlines,
      this.rightIcon,
      this.maxlines,
      this.validator});
  final int? minlines;
  final int? maxlines;
  final TextEditingController controller;
  final String hintText;
  final String? icon;
  final Widget? rightIcon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: maxlines,
        controller: controller,
        minLines: minlines,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: textFieldBorderColor, width: 2.0),
              borderRadius: kradius20),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green, width: 1.0),
              borderRadius: kradius20),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: kradius20),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
              borderRadius: kradius20),
        ));
  }
}

class CustomTextField2 extends StatefulWidget {
  const CustomTextField2({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    // this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  // final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

bool isObsecure = true;

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(0),
      child: StatefulBuilder(
        builder: (context, setState) {
          // bool isObscure = isObsecure;
          return TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: isObsecure,
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: textFieldBorderColor, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: kradius20,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
                borderRadius: kradius20,
              ),
            ),
          );
        },
      ),
    );
  }
}
