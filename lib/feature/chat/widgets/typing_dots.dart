import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypingDots extends StatelessWidget {
  const TypingDots();

  @override
  Widget build(BuildContext context) {
    final c = AppColors.foreground.withAlpha(166);

    Widget dot(int i) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      )
          .animate(onPlay: (controller) => controller.repeat())
          .scaleXY(
        begin: 1,
        end: 1.25,
        duration: 900.ms,
        curve: Curves.easeInOut,
        delay: (i * 180).ms,
      )
          .then()
          .scaleXY(
        begin: 1.25,
        end: 1,
        duration: 900.ms,
        curve: Curves.easeInOut,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot(0),
        SizedBox(width: 6.w),
        dot(1),
        SizedBox(width: 6.w),
        dot(2),
      ],
    );
  }
}