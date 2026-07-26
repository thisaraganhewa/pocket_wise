import 'package:flutter/material.dart';
import 'package:pocket_wise/core/theme/app_colors.dart';
import 'package:pocket_wise/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      fontFamily: 'HankenGrotesk',

      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        error: AppColors.error,
        surface: AppColors.surfaceContainer,
        onSurface: AppColors.textPrimary,
      ),

      textTheme: const TextTheme(
        displayMedium: AppTextStyles.display,
        headlineMedium: AppTextStyles.headline,
        titleMedium: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        labelMedium: AppTextStyles.label
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceBright,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(
            color: AppColors.border
          )
        )
      ),

      dividerColor: AppColors.border

    );
  }
}
