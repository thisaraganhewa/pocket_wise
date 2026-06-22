import 'package:flutter/material.dart';
import 'package:pocket_wise/core/theme/app_colors.dart';
import 'package:pocket_wise/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme{
    return ThemeData(
      useMaterial3: true,

      fontFamily: 'HankenGrotesk',

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        onSurface: AppColors.neutral, 

      ),

      scaffoldBackgroundColor: Colors.white,

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.headlineXl,
        displayMedium: AppTextStyles.headlineXlMobile,
        titleLarge: AppTextStyles.headlineLg,
        bodyLarge: AppTextStyles.bodyLg,
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.neutral,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.bodyLg.copyWith(
            fontWeight: FontWeight.w600,
          )
        )
      )

    );
  }

}