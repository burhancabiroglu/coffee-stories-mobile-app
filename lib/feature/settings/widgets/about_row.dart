import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

class AboutRow extends StatelessWidget {
  const AboutRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.foreground.withAlpha(166),
            fontSize: 13.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.foreground.withAlpha(166),
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}