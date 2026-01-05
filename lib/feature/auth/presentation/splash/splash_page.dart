import 'package:coffeestories/feature/auth/presentation/splash/splash_cubit.dart';
import 'package:coffeestories/feature/auth/presentation/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../widgets/coffee_icon.dart';
import '../../widgets/splash_subtitle.dart';
import '../../widgets/splash_title.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.when(
          loading: () {},
          goHome: () => context.go(RouteNames.home),
          goOnboarding: () => context.go(RouteNames.onboarding),
          goLogin: () => context.go(RouteNames.login),
          forceUpdate: () {},
        );
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.accent,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CoffeeIcon(size: 96.w),
                SizedBox(height: 20.h),
                SplashTitle(fontSize: 26.sp),
                SizedBox(height: 8.h),
                SplashSubtitle(fontSize: 14.sp),
              ],
            ),
          ),
        )
            .animate()
            .fadeOut(duration: 10000.ms),
      ),
    );
  }
}