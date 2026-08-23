import 'package:flutter/material.dart';
import 'package:pocket_wise/core/theme/app_colors.dart';
import 'package:pocket_wise/core/theme/app_text_styles.dart';

class GoogleSignInButton extends StatelessWidget {

  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceBright,
          side: const BorderSide(
            color: AppColors.border
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google_logo.png',
              width: 22,
              height: 22,
            ),
            const SizedBox(width: 12,),
            Text(
              'Continue with google',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        )
      ),
    );
  }
}