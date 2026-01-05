import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import 'home_primary_button.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon bubble in a soft circle
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.foreground.withOpacity(0.06),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 40.sp,
                  color: AppColors.foreground.withOpacity(0.65),
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                'Yeni Bir Sohbet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.foreground,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                'Kahvenizi hazırlayın, rahat edin ve paylaşmak istediklerinizi anlatın.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.foreground.withOpacity(0.65),
                  fontSize: 14.sp,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 24.h),

              // Primary: Yazılı Sohbet
              HomePrimaryButton(
                label: 'Yazılı Sohbet',
                icon: Icons.chat_bubble_outline,
                onTap: () => context.go(RouteNames.camera),
              ),
              SizedBox(height: 12.h),

              // Secondary: Sesli Sohbet (outline)
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton.icon(
                  onPressed: () => context.go(RouteNames.camera),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    side: BorderSide(
                      color: AppColors.foreground.withOpacity(0.14),
                      width: 1,
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.foreground,
                  ),
                  icon: Icon(
                    Icons.mic_none,
                    size: 20.sp,
                  ),
                  label: Text(
                    'Sesli Sohbet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
