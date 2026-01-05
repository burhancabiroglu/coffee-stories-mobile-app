import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashSubtitle extends StatelessWidget {
  final double? fontSize;

  const SplashSubtitle({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Düşünceli Sohbetler',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: fontSize ?? 14.sp,
        color: Colors.white.withAlpha(204), // 0.8 * 255 ≈ 204
      ),
    )
        .animate(delay: 500.ms)
        .moveY(begin: 20, end: 0)
        .fadeIn(duration: 600.ms);
  }
}