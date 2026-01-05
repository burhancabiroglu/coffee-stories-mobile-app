import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/app_flow_cubit.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../widgets/coffee_icon.dart';
import '../../widgets/splash_subtitle.dart';
import '../../widgets/splash_title.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // React: setTimeout(onComplete, 2500)
    _timer = Timer(const Duration(milliseconds: 2500), _onComplete);
  }

  void _onComplete() {
    if (!mounted) return;

    final flow = context.read<AppFlowCubit>();

    // Splash sadece bootstrap bekler.
    // Router redirect logic nereye gideceğini zaten biliyor.
    if (flow.state.isBootstrapped) {
      context.go(RouteNames.onboarding);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}