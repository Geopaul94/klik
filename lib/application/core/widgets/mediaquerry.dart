import 'package:flutter/material.dart';

double screenHeight(BuildContext context, {double fraction = 1}) {
  return MediaQuery.of(context).size.height * fraction;
}

double screenWidth(BuildContext context, {double fraction = 1}) {
  return MediaQuery.of(context).size.width * fraction;
}
