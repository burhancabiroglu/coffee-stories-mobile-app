import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/router/route_names.dart';
import '../../widgets/about_row.dart';
import '../../widgets/legal_link.dart';
import '../../widgets/settings_option.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/settings_user_card_row.dart';
import './settings_cubit.dart';
import './settings_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = context.read<SettingsCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final options = <SettingsOption>[
      SettingsOption(
        id: 'profile',
        icon: Icons.person_outline,
        title: 'Profil Bilgileri',
        description: 'Hesap bilgilerinizi düzenleyin',
        onTap: () => context.push(RouteNames.settingsProfile),
      ),
      SettingsOption(
        id: 'notifications',
        icon: Icons.notifications_none,
        title: 'Bildirimler',
        description: 'Bildirim tercihlerinizi yönetin',
        onTap: () => context.push(RouteNames.settingsNotifications),
      ),
      SettingsOption(
        id: 'privacy',
        icon: Icons.shield_outlined,
        title: 'Gizlilik ve Güvenlik',
        description: 'Gizlilik ayarlarınızı kontrol edin',
        onTap: () => context.push(RouteNames.settingsPrivacy),
      ),
      SettingsOption(
        id: 'help',
        icon: Icons.help_outline,
        title: 'Yardım ve Destek',
        description: 'SSS ve destek merkezi',
        onTap: () => context.push(RouteNames.settingsHelp),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header
            Container(
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
                        'Ayarlar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.foreground,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Hesap ve tercihleriniz',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.foreground.withAlpha(166),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 20.h),
                children: [
                  // User info card (gradient 느낌)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: AppColors.foreground.withAlpha(20),
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withAlpha(26), // ~10%
                          AppColors.foreground.withAlpha(16),
                        ],
                      ),
                    ),
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () => SizedBox(
                            height: 56.w,
                            child: const Center(child: CircularProgressIndicator.adaptive()),
                          ),
                          ready: (displayName, email, initials, credits, isLoggingOut) {
                            return SettingsUserCardRow(
                              displayName: displayName,
                              email: email,
                              initials: initials,
                              credits: credits,
                            );
                          },
                          error: (message, displayNameFallback, emailFallback, initialsFallback, creditsFallback) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SettingsUserCardRow(
                                  displayName: displayNameFallback,
                                  email: emailFallback,
                                  initials: initialsFallback,
                                  credits: creditsFallback,
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        message,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.foreground.withAlpha(166),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: cubit.load,
                                      child: const Text('Tekrar dene'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.08, end: 0, duration: 220.ms),

                  SizedBox(height: 18.h),

                  // Options
                  ...List.generate(options.length, (i) {
                    final opt = options[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: SettingsOptionTile(option: opt)
                          .animate()
                          .fadeIn(duration: 220.ms, delay: (80 * i).ms)
                          .slideX(begin: -0.06, end: 0, duration: 220.ms, delay: (80 * i).ms),
                    );
                  }),

                  SizedBox(height: 14.h),

                  // About card
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.foreground.withAlpha(10),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hakkında',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.foreground,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        AboutRow(label: 'Versiyon', value: '1.0.0'),
                        SizedBox(height: 8.h),
                        AboutRow(label: 'Son Güncelleme', value: '3 Ocak 2026'),
                      ],
                    ),
                  ).animate().fadeIn(duration: 220.ms, delay: 320.ms),

                  SizedBox(height: 14.h),

                  // Legal links
                  LegalLink(
                    label: 'Kullanım Koşulları',
                    onTap: () => context.push(RouteNames.settingsTerms),
                  ),
                  SizedBox(height: 8.h),
                  LegalLink(
                    label: 'Gizlilik Politikası',
                    onTap: () => context.push(RouteNames.settingsPrivacyPolicy),
                  ),
                ],
              ),
            ),

            // Logout
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.foreground.withAlpha(20),
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54.h,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final isLoggingOut = state.maybeWhen(
                      ready: (_, __, ___, ____, isLoggingOut) => isLoggingOut,
                      orElse: () => false,
                    );

                    return OutlinedButton.icon(
                      onPressed: isLoggingOut ? null : () => cubit.logout(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red.withAlpha(18),
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red.withAlpha(40), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      icon: Icon(Icons.logout, size: 20.sp),
                      label: Text(
                        isLoggingOut ? 'Çıkış Yapılıyor...' : 'Çıkış Yap',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                    ).animate().fadeIn(duration: 220.ms, delay: 380.ms);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
