import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashTitle extends StatelessWidget {
  final double? fontSize;

  const SplashTitle({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Telveden Hikâyeler',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: fontSize ?? 26.sp,
        color: Colors.white.withAlpha(255),
        letterSpacing: 1.0,
      ),
    )
    // React: y: 20 → 0, opacity 0 → 1
        .animate(delay: 300.ms)
        .moveY(begin: 20, end: 0)
        .fadeIn(duration: 600.ms);
  }
}