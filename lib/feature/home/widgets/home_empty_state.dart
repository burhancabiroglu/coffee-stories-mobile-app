import 'package:coffeestories/core/widgets/secondary_button.dart';
import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';

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
              PrimaryButton(
                label: 'Yazılı Sohbet',
                icon: Icons.chat_bubble_outline,
                onTap: () => context.push(
                  RouteNames.chatFlow,
                  extra: ChatFlowArgs.text(),
                ),
              ),
              SizedBox(height: 12.h),
              // Secondary: Sesli Sohbet (outline)
              SecondaryButton(
                label: 'Sesli Sohbet',
                icon: Icons.mic_none,
                onTap: () => context.push(
                  RouteNames.chatFlow,
                  extra: ChatFlowArgs.voice(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
