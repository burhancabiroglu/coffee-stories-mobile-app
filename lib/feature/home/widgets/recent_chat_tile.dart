
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../data/model/recent_chat.dart';

class RecentChatTile extends StatelessWidget {
  final RecentChat chat;
  final VoidCallback onTap;

  const RecentChatTile({
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.border, // hover yok; ama border zaten var
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      chat.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.foreground,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    chat.date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedForeground,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                chat.preview,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedForeground,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

