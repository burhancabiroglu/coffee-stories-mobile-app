import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import '../domain/recent_chat.dart';
import '../widgets/home_credit_card.dart';
import '../widgets/home_empty_state.dart';
import '../widgets/home_header.dart';
import '../widgets/home_primary_button.dart';
import '../widgets/recent_chat_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _recentChats = <RecentChat>[
    RecentChat(
      id: 1,
      title: 'Akşam Sohbeti',
      date: '2 Ocak 2026',
      preview: 'Bugün hava çok güzeldi...',
    ),
    RecentChat(
      id: 2,
      title: 'Sabah Kahvesi',
      date: '1 Ocak 2026',
      preview: 'Yeni yılın ilk günü...',
    ),
    RecentChat(
      id: 3,
      title: 'Düşünceler',
      date: '31 Aralık 2025',
      preview: 'Yılbaşı gecesi düşünceleri...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false, // React’te pt-12 var; biz padding ile çözeceğiz
        child: Column(
          children: [
            // HEADER + CREDIT CARD
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 64.h, 24.w, 24.h),
              child: Column(
                children: [
                  HomeHeader(
                    onSettings: () => context.go(RouteNames.settings),
                  ),
                  SizedBox(height: 24.h),
                  HomeCreditCard(
                    credits: 250,
                    onBuyCredits: () => context.go(RouteNames.creditPurchase),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 350.ms)
                .slideY(begin: -0.10, end: 0, duration: 350.ms, curve: Curves.easeOut),

            // RECENT CHATS / EMPTY STATE
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: _recentChats.isEmpty
                    ? const HomeEmptyState()
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          duration: 300.ms,
                          curve: Curves.easeOut,
                        )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Son Sohbetler',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.foreground,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 12.h),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 12.h),
                              itemCount: _recentChats.length,
                              separatorBuilder: (_, __) => SizedBox(height: 12.h),
                              itemBuilder: (context, index) {
                                final chat = _recentChats[index];
                                return RecentChatTile(
                                  chat: chat,
                                  onTap: () => context.go(RouteNames.camera), // React’te onStartChat
                                )
                                    .animate()
                                    .fadeIn(
                                      duration: 300.ms,
                                      delay: (100 * index).ms,
                                    )
                                    .slideX(
                                      begin: -0.10,
                                      end: 0,
                                      duration: 300.ms,
                                      delay: (100 * index).ms,
                                      curve: Curves.easeOut,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // BOTTOM CTA (only when there are recent chats)
            if (_recentChats.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Secondary: Sesli Sohbet
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
                          'Sesli Sohbet Başlat',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Primary: Yeni Sohbet
                    HomePrimaryButton(
                      label: 'Yeni Sohbet Başlat',
                      icon: Icons.chat_bubble_outline,
                      onTap: () => context.go(RouteNames.camera),
                    ),
                  ],
                ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.10, end: 0, duration: 250.ms),
              ),
          ],
        ),
      ),
    );
  }
}
