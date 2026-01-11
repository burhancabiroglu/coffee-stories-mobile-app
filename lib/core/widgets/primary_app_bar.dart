import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';

class PrimaryAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const PrimaryAppBar({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 64.h, 24.w, 20.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.foreground.withAlpha(20),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44.w,
            height: 44.w,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(RouteNames.home);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.foreground.withAlpha(16),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.sp,
                  color: AppColors.foreground,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.foreground,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.foreground.withAlpha(166),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
