import 'package:flutter/material.dart';

final class AppColors {
  // Core surfaces
  static const background = Color(0xFFFAF7F2); // --background
  static const foreground = Color(0xFF3D2817); // --foreground

  static const card = Color(0xFFFFFFFF); // --card
  static const cardForeground = Color(0xFF3D2817); // --card-foreground

  static const popover = Color(0xFFFFFFFF); // --popover
  static const popoverForeground = Color(0xFF3D2817); // --popover-foreground

  // Brand
  static const primary = Color(0xFF8B5A3C); // --primary
  static const onPrimary = Color(0xFFFFFFFF); // --primary-foreground

  static const secondary = Color(0xFFE8DDD0); // --secondary
  static const onSecondary = Color(0xFF3D2817); // --secondary-foreground

  // Muted / accent
  static const muted = Color(0xFFF5EFE7); // --muted
  static const mutedForeground = Color(0xFF7A6854); // --muted-foreground

  static const accent = Color(0xFFD4C4B0); // --accent
  static const onAccent = Color(0xFF3D2817); // --accent-foreground

  // Status
  static const destructive = Color(0xFFC44536); // --destructive
  static const onDestructive = Color(0xFFFFFFFF); // --destructive-foreground

  // Inputs / borders
  /// CSS: rgba(139, 90, 60, 0.15)
  static const border = Color.fromRGBO(139, 90, 60, 0.15);
  static const inputBackground = Color(0xFFF5EFE7); // --input-background
  static const switchBackground = Color(0xFFD4C4B0); // --switch-background

  // Focus ring
  static const ring = Color(0xFF8B5A3C); // --ring

  // AI subtle accents (gradient / highlights)
  static const aiCyan = Color(0xFF60D5DC);
  static const aiBlue = Color(0xFF4A90E2);
  static const aiPurple = Color(0xFF9B59B6);
  static const aiPink = Color(0xFFE88CAE);

  /// A handy outline color used across components.
  static const outline = border;
}