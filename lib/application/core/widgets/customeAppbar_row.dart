
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/application/core/widgets/custome_icons.dart';
import 'package:klik/application/core/widgets/custome_linear%20colorgradient.dart';

class CustomeAppbarRow extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final String title;
  final Function() onBackButtonPressed;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Color? iconColor;

  const CustomeAppbarRow({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.onBackButtonPressed,
    this.gradientColors = const [Colors.blue, Colors.green],
    this.backgroundColor = Colors.black,
    this.iconColor,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: backgroundColor,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBackButtonPressed,
            child: SizedBox(
              height: height * 0.05,
              width: width * 0.34,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomGradientIcon(
                  icon: CupertinoIcons.back,
                ),
              ),
            ),
          ),
          Center(
            child: CustomeLinearcolor(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              text: title,
              gradientColors: gradientColors,
            ),
          ),
        ],
      ),
    );
  }
}
