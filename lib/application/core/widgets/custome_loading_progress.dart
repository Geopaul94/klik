import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:flutter/material.dart';
class CustomeLoadingProgressSearch extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final double radius;

  const CustomeLoadingProgressSearch({
    super.key,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.green,
    this.radius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        NutsActivityIndicator(
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          radius: radius,
          tickCount: 30, // Customize number of ticks
          relativeWidth: 0.3, // Width of each tick relative to radius
          startRatio: 0.9, // Start ratio for ticks
          animationDuration: const Duration(milliseconds: 500), // Animation duration
        ),
        Icon(
          Icons.search,
          color: Colors.white, // Change color as needed
          size: radius / 2, // Adjust size relative to radius
        ),
      ],
    );
  }
}
