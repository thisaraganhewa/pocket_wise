import 'package:flutter/material.dart';

class AppTextStyles {
  
  AppTextStyles._();

  static const display = TextStyle(
    fontFamily: 'HankenGrotesk',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.64,
  );

  static const headline = TextStyle(
    fontFamily: 'HankenGrotesk',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24
  );

  static const title = TextStyle(
    fontFamily: 'HankenGrotesk',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 28 / 18
  );

  static const body = TextStyle(
    fontFamily: 'HankenGrotesk',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16
  );

  static const label = TextStyle(
    fontFamily: 'HankenGrotesk',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2
  );

}
