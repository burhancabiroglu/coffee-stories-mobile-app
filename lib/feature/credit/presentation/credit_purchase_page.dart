import 'package:coffeestories/core/widgets/primary_button.dart';
import 'package:coffeestories/core/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/primary_app_bar.dart';
import '../widgets/credit_package.dart';
import '../widgets/info_bullet.dart';
import 'credit_purchase_cubit.dart';
import 'credit_purchase_state.dart';

class CreditPurchasePage extends StatefulWidget {
  const CreditPurchasePage({super.key});

  @override
  State<CreditPurchasePage> createState() => _CreditPurchasePageState();
}

class _CreditPurchasePageState extends State<CreditPurchasePage> {
  late final CreditPurchaseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CreditPurchaseCubit>();
    // Trigger initial load once the widget is in the tree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.load();
    });
  }

  Color get _borderColor => AppColors.foreground.withAlpha(20); // border-border
  Color get _mutedBg => AppColors.foreground.withAlpha(12); // muted
  Color get _mutedFg => AppColors.foreground.withAlpha(166); // muted-foreground
  Color get _accentSoft => AppColors.primary.withAlpha(26); // accent/10-20 hissi

  void onBack() {
    context.canPop() ? context.pop() : context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditPurchaseCubit, CreditPurchaseState>(
        listenWhen: (prev, next) {
          final prevMsg = prev.maybeWhen(ready: (_, __, ___, ____, _____, message) => message, orElse: () => null);
          final nextMsg = next.maybeWhen(ready: (_, __, ___, ____, _____, message) => message, orElse: () => null);
          return nextMsg != null && nextMsg != prevMsg;
        },
        listener: (context, state) {
          state.maybeWhen(
            ready: (_, __, ___, ____, _____, message) {
              if (message == null) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              context.read<CreditPurchaseCubit>().clearMessage();
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<CreditPurchaseCubit, CreditPurchaseState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                top: false,
                child: Column(
                  children: [
                    // Header
                    PrimaryAppBar(title: 'Kredi Satın Al', subtitle: 'Sohbet kredinizi artırın'),
                    // BODY
                    Expanded(
                      child: state.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (message, creditsFallback, packagesFallback, selectedPackageIdFallback) {
                          return Padding(
                            padding: EdgeInsets.all(24.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.foreground, fontSize: 14.sp),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48.h,
                                  child: OutlinedButton(
                                    onPressed: () => cubit.load(),
                                    child: const Text('Tekrar Dene'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        ready: (currentCredits, packages, selectedPackageId, isPurchasing, isWatchingAd, message) {
                          return ListView(
                            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                            children: [
                              ...List.generate(packages.length, (index) {
                                final pkg = packages[index];
                                final isSelected = pkg.id == selectedPackageId;

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: PackageTile(
                                    package: pkg,
                                    isSelected: isSelected,
                                    borderColor: _borderColor,
                                    mutedFg: _mutedFg,
                                    accentSoft: _accentSoft,
                                    onTap: () => cubit.selectPackage(pkg.id),
                                  )
                                      .animate()
                                      .fadeIn(duration: 220.ms, delay: (100 * index).ms)
                                      .slideY(begin: 0.10, end: 0, duration: 220.ms, delay: (100 * index).ms),
                                );
                              }),

                              Container(
                                margin: EdgeInsets.only(top: 16.h),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: _mutedBg,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kredi Kullanımı',
                                      style: TextStyle(
                                        color: AppColors.foreground,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    InfoBullet(text: 'Her sohbet mesajı ortalama 10 kredi kullanır', color: _mutedFg),
                                    SizedBox(height: 8.h),
                                    InfoBullet(text: 'Krediler hesabınızda süresiz kalır', color: _mutedFg),
                                    SizedBox(height: 8.h),
                                    InfoBullet(text: 'İstediğiniz zaman kullanabilirsiniz', color: _mutedFg),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 200.ms, delay: 480.ms),
                            ],
                          );
                        },
                      ),
                    ),

                    // FOOTER (only enabled in ready)
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: _borderColor, width: 1)),
                      ),
                      child: state.maybeWhen(
                        ready: (currentCredits, packages, selectedPackageId, isPurchasing, isWatchingAd, message) {
                          final busy = isPurchasing || isWatchingAd;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SecondaryButton(
                                label: busy && isWatchingAd ? 'Reklam Yükleniyor...' : 'Reklam İzle Kazan',
                                onTap:  busy ? null : () => cubit.watchAdToEarn(),
                                icon: Icons.ondemand_video,
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.infinity,
                                height: 56.h,
                                child: PrimaryButton(
                                  onTap: busy ? null : () => cubit.purchaseSelected(),
                                  label: busy && isPurchasing ? 'İşleniyor...' : 'Satın Al'
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Text(
                                  'Güvenli ödeme ile korunan işlem',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: _mutedFg,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
