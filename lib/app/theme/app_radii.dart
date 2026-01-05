import 'package:flutter/material.dart';

final class AppRadii {
  static const base = 10.0; // 0.625rem -> 10px

  static const sm = Radius.circular(base - 4); // 6
  static const md = Radius.circular(base - 2); // 8
  static const lg = Radius.circular(base); // 10
  static const xl = Radius.circular(base + 4); // 14

  static const borderRadiusSm = BorderRadius.all(sm);
  static const borderRadiusMd = BorderRadius.all(md);
  static const borderRadiusLg = BorderRadius.all(lg);
  static const borderRadiusXl = BorderRadius.all(xl);
}