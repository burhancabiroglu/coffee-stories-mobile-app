
import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const SecondaryButton({
    required this.label,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          side: BorderSide(
            color: AppColors.foreground.withAlpha(36), // 0.14 * 255 ≈ 36
            width: 1,
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.foreground,
        ),
        icon: Icon(
          icon,
          size: 20.sp,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}