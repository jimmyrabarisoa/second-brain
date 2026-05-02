import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String _serif = 'InstrumentSerif';
  static const String _sans  = 'Inter';

  static const TextStyle h1 = TextStyle(
    fontFamily: _serif,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.foreground,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _serif,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.foreground,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _sans,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.foreground,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _sans,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.foreground,
    height: 1.6,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontFamily: _sans,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.muted,
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _sans,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.muted,
    height: 1.4,
  );

  static const TextStyle label = TextStyle(
    fontFamily: _sans,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.foreground,
  );

  static TextTheme get textTheme => const TextTheme(
        displayLarge: h1,
        displayMedium: h2,
        titleLarge: h3,
        bodyLarge: body,
        bodyMedium: body,
        bodySmall: caption,
        labelLarge: label,
        labelSmall: caption,
      );
}
