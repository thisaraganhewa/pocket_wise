import 'package:flutter/material.dart';
import 'package:pocket_wise/core/theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        gradient: RadialGradient(
          colors: [Color(0xFF3A1833), AppColors.background],
          center: Alignment(-1.0, -1.0),
          radius: 1.4,
          stops: [
            0.0,
            0.65
          ],

        ),
      ),
      child: child,
    );
  }
}
