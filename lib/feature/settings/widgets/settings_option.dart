import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

class SettingsOption {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  SettingsOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });
}

class SettingsOptionTile extends StatelessWidget {
  const SettingsOptionTile({required this.option});

  final SettingsOption option;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: option.onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.foreground.withAlpha(20),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withAlpha(26),
              ),
              alignment: Alignment.center,
              child: Icon(
                option.icon,
                size: 20.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.foreground,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    option.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.foreground.withAlpha(166),
                      fontSize: 12.sp,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 22.sp,
              color: AppColors.foreground.withAlpha(120),
            ),
          ],
        ),
      ),
    );
  }
}
