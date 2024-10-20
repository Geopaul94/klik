import 'package:flutter/material.dart';

class CustomGradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final List<Color> gradientColors;

  const CustomGradientIcon({super.key, 
    required this.icon,
    this.size = 24.0,
    this.gradientColors = const [Colors.blue, Colors.green],
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        size: size,
        color: Colors.white, // Base color to apply the gradient
      ),
    );
  }
}
