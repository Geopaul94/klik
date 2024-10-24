
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/application/core/constants/constants.dart';



class SpinningLinesExample extends StatelessWidget {
  const SpinningLinesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Use a percentage of the parent's constraints
            double size = constraints.biggest.shortestSide * 0.3; // 30% of the shortest side
            return SpinKitSpinningLines(
              color: Colors.green,
              size: size,
            );
          },
        ),
      ),
    );
  }
}

