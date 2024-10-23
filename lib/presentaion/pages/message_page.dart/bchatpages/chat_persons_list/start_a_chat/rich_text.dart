

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/presentaion/pages/homepage/suggession_page.dart';


class Richtext extends StatelessWidget {
  const Richtext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
            text: 'Go to  ',
            style: TextStyle(
                color: black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigatePushAnimaterbottomtotop(
                    context, const SuggessionPage());
              },
            text: 'Suggessions?',
            style: const TextStyle(
                color: green,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15))
      ]),
    );
  }
  
  void navigatePushAnimaterbottomtotop(BuildContext context, suggessionScreen) {}
}
