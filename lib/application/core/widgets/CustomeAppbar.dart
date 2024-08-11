import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? startColor;
  final Color? endColor;
  final IconData? leadingIcon;
  final IconData? cupertinoLeadingIcon;
  final double? leadingIconSize;
  final double? leadingIconPadding;
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final bool isTitleBold;
  final bool showBackArrow;

  const CustomAppBar({
    Key? key,
    this.startColor,
    this.endColor,
    this.leadingIcon,
    this.cupertinoLeadingIcon,
    this.leadingIconSize,
    this.leadingIconPadding,
    required this.title,
    this.titleStyle,
    this.centerTitle = true,
    this.isTitleBold = false,
    this.showBackArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? (leadingIcon != null
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
                  child: Padding(
                    padding: EdgeInsets.only(left: leadingIconPadding ?? 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        leadingIcon,
                        size: leadingIconSize,
                      ),
                    ),
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
                  : null)
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
                fontSize: MediaQuery.of(context).size.width * 0.05,
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

