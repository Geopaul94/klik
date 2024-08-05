import 'package:flutter/material.dart';

Widget textBoxWidget(
    {required BuildContext context,
    required TextEditingController controller,
    VoidCallback? validator}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(),
    ),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 30),
      decoration: const InputDecoration(counterText: ""),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}
