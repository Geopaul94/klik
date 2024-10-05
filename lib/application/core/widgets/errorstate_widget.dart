import 'package:flutter/material.dart';

Widget errorStateWidget(String text,TextStyle style ,Color color) {
  return Center(
    child: Text(text,style: style, selectionColor: color,),
  );
}
