import 'package:coffeestories/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ConversationEndPage extends StatelessWidget {
  const ConversationEndPage({
    super.key
  });

  Color get _mutedBg => AppColors.foreground.withAlpha(12); // muted
  Color get _mutedFg => AppColors.foreground.withAlpha(166); // muted-foreground
  Color get _secondarySoft => AppColors.foreground.withAlpha(10); // bg-muted/30
  Color get _secondaryCircle => AppColors.foreground.withAlpha(16); // bg-secondary/50 hissi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Content
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 420.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon
                        Container(
                          width: 96.w, // w-24
                          height: 96.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _secondaryCircle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.coffee,
                            size: 44.sp, // w-12
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 28.h),

                        // Message
                        Column(
                          children: [
                            Text(
                              'Teşekkür ederiz',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.foreground,
                                fontSize: 28.sp, // text-3xl hissi
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Bu samimi sohbet için teşekkür ederiz.\nKendinize iyi bakın, '
                                  've ne zaman isterseniz tekrar gelin.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: _mutedFg,
                                fontSize: 14.sp,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 28.h),

                        // Quote
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: _secondarySoft,
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: AppColors.foreground.withAlpha(18),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 4.w, // border-l-4
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Center(
                                child: Text(
                                  '"Bir fincan kahvenin kırk yıl hatırı vardır."',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.foreground,
                                    fontSize: 13.sp,
                                    fontStyle: FontStyle.italic,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 420.ms)
                        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1), duration: 420.ms),
                  ),
                ),
              ),
            ),

            // Actions
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton.icon(
                      onPressed: () {} , //onNewConversation
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      icon: Icon(Icons.chat_bubble_outline, size: 20.sp),
                      label: Text(
                        'Yeni Sohbet',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go(RouteNames.home),//onHome
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.foreground,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: AppColors.foreground.withAlpha(20), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      icon: Icon(Icons.coffee, size: 20.sp, color: AppColors.foreground),
                      label: Text(
                        'Ana Sayfaya Dön',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 220.ms, delay: 120.ms),
            ),
          ],
        ),
      ),
    );
  }
}