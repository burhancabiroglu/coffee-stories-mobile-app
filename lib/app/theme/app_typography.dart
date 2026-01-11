import 'package:flutter/material.dart';

final class AppTypography {
  static const String? fontFamily = "Inter";

  static TextTheme textTheme(Color foreground) {
    // Flutter Material 3 naming:
    // display/headline/title/body/label
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24, // h1 ~ 2xl
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 20, // h2 ~ xl
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 18, // h3 ~ lg
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16, // h4/label/button base
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: foreground,
        fontFamily: fontFamily,
      ),
    );
  }
}