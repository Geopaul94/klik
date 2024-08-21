
import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

Widget userNameAndBio(String userName,String bio) {
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(userName, style: appBarTitleStyle),
      Text(bio)
    ],
  );
}
