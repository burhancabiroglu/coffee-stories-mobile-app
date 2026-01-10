import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

class SettingsUserCardRow extends StatelessWidget {
  const SettingsUserCardRow({
    required this.displayName,
    required this.email,
    required this.initials,
    required this.credits,
  });

  final String displayName;
  final String email;
  final String initials;
  final int credits;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withAlpha(180),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.foreground,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                email,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.foreground.withAlpha(166),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.foreground.withAlpha(16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '$credits Kredi',
                      style: TextStyle(
                        color: AppColors.foreground,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
