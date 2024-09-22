
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRowWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String date;
  final double imageRadius;
  final Function(TapDownDetails) onIconTap;
  final Color userNameColor;
  final Color dateColor;
  final double userNameFontSize;
  final double dateFontSize;
   final bool showIcon;

  const UserRowWidget({
    Key? key,
    required this.profileImageUrl,
    required this.userName,
    required this.date,
    required this.onIconTap,
    this.imageRadius = 30.0,
    this.userNameColor = Colors.white,
    this.dateColor = Colors.grey,
    this.userNameFontSize = 18.0,
    this.dateFontSize = 14.0,  this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: imageRadius,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                color: userNameColor,
                fontSize: userNameFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: dateColor,
                fontSize: dateFontSize,
              ),
            ),
          ],
        ),
        const Spacer(),
          if (showIcon && onIconTap != null)
          GestureDetector(
            onTapDown: onIconTap,
            child: const Icon(
              CupertinoIcons.ellipsis_vertical,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}