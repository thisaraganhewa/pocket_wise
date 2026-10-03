import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pocket_wise/core/theme/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: AppColors.background),

        Positioned(
          top: -180,
          left: -180,
          child: _Glow(
            color: AppColors.primary,
            size: 500,
            blur: 140,
            opacity: 0.16,
          ),
        ),

        Positioned(
          right: -180,
          bottom: -180,
          child: _Glow(
            color: AppColors.tertiary,
            size: 500,
            blur: 140,
            opacity: 0.10,
          ),
        ),

        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  final double size;
  final double blur;
  final double opacity;

  const _Glow({
    required this.color,
    required this.size,
    required this.blur,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: opacity),
        ),
      ),
    );
  }
}
