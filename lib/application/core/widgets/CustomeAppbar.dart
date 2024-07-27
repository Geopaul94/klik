import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? startColor;
  final Color? endColor;
  final IconData? leadingIcon;
  final IconData? cupertinoLeadingIcon;
  final double? leadingIconSize;
  final double? leadingIconPadding; // Add this for leading icon padding
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final bool isTitleBold;

  const CustomAppBar({
    Key? key,
    this.startColor,
    this.endColor,
    this.leadingIcon,
    this.cupertinoLeadingIcon,
    this.leadingIconSize,
    this.leadingIconPadding, // Add this
    required this.title,
    this.titleStyle,
    this.centerTitle = true,
    this.isTitleBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingIcon != null
          ? ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  colors: [startColor ?? Colors.blue, endColor ?? Colors.green],
                  stops: [0.0, 1.0],
                ).createShader(rect);
              },
              child: Row(
                children: [
                  SizedBox(
                      width: leadingIconPadding ?? 20), 
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      leadingIcon,
                      size: leadingIconSize,
                    ),
                  ),
                ],
              ),
            )
          : cupertinoLeadingIcon != null
              ? ShaderMask(
                  shaderCallback: (Rect rect) {
                    return LinearGradient(
                      colors: [
                        startColor ?? Colors.blue,
                        endColor ?? Colors.green
                      ],
                      stops: [0.0, 1.0],
                    ).createShader(rect);
                  },
                  child: Icon(
                    cupertinoLeadingIcon,
                    size: leadingIconSize,
                  ),
                )
              : null,
      title: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            colors: [startColor ?? Colors.blue, endColor ?? Colors.green],
            stops: [0.0, 1.0],
          ).createShader(rect);
        },
        child: Text(
          title,
          style: titleStyle ??
              TextStyle(
                fontSize: MediaQuery.of(context).size.width *
                    0.05, // Use media query for font size
                fontWeight: isTitleBold ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
