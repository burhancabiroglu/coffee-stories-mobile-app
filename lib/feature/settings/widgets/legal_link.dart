import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

class LegalLink extends StatelessWidget {
  const LegalLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.foreground.withAlpha(166),
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}