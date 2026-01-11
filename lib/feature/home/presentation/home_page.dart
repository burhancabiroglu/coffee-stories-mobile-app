import 'package:coffeestories/core/widgets/primary_button.dart';
import 'package:coffeestories/core/widgets/secondary_button.dart';
import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/home_credit_card.dart';
import '../widgets/home_empty_state.dart';
import '../widgets/home_header.dart';
import '../widgets/recent_chat_tile.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<HomeCubit>();

    // Trigger initial load once the widget is in the tree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.load();
    });
  }
  Color get _bgTop => const Color(0xFFF6F1EB);
  Color get _bgMid => const Color(0xFFEFE5D8);
  Color get _bgBottom => const Color(0xFFEAF1F6);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = _cubit;

        final credits = state.maybeWhen(
          ready: (credits, _) => credits,
          empty: (credits) => credits,
          error: (_, creditsFallback, __) => creditsFallback,
          orElse: () => 0,
        );

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_bgTop, _bgMid, _bgBottom],
              )
            ),
            child: SafeArea(
              top: false, // React’te pt-12 var; biz padding ile çözeceğiz
              child: Column(
                children: [
                  // HEADER + CREDIT CARD
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 64.h, 24.w, 24.h),
                    child: Column(
                      children: [
                        HomeHeader(
                          onSettings: () => context.push(RouteNames.settings),
                        ),
                        SizedBox(height: 24.h),
                        HomeCreditCard(
                          credits: credits,
                          onBuyCredits: () => context.push(RouteNames.creditPurchase),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 350.ms)
                      .slideY(begin: -0.10, end: 0, duration: 350.ms, curve: Curves.easeOut),

                  // CONTENT (loading / error / empty / list)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: state.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (message, creditsFallback, recentChatsFallback) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Bir şeyler ters gitti',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.foreground,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                message,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.foreground.withAlpha(166), // 0.65 * 255 ≈ 166
                                      fontSize: 14.sp,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.h),
                              SizedBox(
                                width: double.infinity,
                                height: 52.h,
                                child: OutlinedButton(
                                  onPressed: () => cubit.refresh(),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    side: BorderSide(
                                      color: AppColors.foreground.withAlpha(36), // 0.14 * 255 ≈ 36
                                      width: 1,
                                    ),
                                    foregroundColor: AppColors.foreground,
                                  ),
                                  child: Text(
                                    'Tekrar Dene',
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
                        empty: (credits) => const HomeEmptyState()
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .slideY(
                              begin: 0.08,
                              end: 0,
                              duration: 300.ms,
                              curve: Curves.easeOut,
                            ),
                        ready: (credits, recentChats) => Column(
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
                                itemCount: recentChats.length,
                                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final chat = recentChats[index];
                                  return RecentChatTile(
                                    chat: chat,
                                    onTap: () => context.push(
                                      RouteNames.chatFlow,
                                      extra: ChatFlowArgs.previous(id: "234234")
                                    ),
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
                  ),

                  // BOTTOM CTA (only when there are recent chats)
                  if (state.maybeWhen(ready: (_, chats) => chats.isNotEmpty, orElse: () => false))
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 12.h,
                        children: [
                          // Secondary: Sesli Sohbet
                          SecondaryButton(
                            label: 'Sesli Sohbet Başlat',
                            icon: Icons.mic_none,
                            onTap: () => context.push(
                              RouteNames.chatFlow,
                              extra: ChatFlowArgs.voice()
                            )
                          ),
                          // Primary: Yeni Sohbet
                          PrimaryButton(
                            label: 'Yeni Sohbet Başlat',
                            icon: Icons.chat_bubble_outline,
                            onTap: () => context.go(
                              RouteNames.chatFlow,
                              extra: ChatFlowArgs.text()
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.10, end: 0, duration: 250.ms),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
