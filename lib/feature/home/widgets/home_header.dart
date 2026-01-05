
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import 'home_coffee_mark.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onSettings;

  const HomeHeader({
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: Logo + Titles
        Expanded(
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.30),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: HomeCoffeeMark(),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telveden Hikâyeler',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.foreground,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Hoş geldiniz',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedForeground,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right: Settings button
        InkWell(
          onTap: onSettings,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.muted,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.settings_outlined,
              size: 20.sp,
              color: AppColors.foreground,
            ),
          ),
        ),
      ],
    );
  }
}

