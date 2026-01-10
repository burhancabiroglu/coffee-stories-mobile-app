import 'dart:io';

import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_flow/chat_flow_cubit.dart';
import '../chat_flow/chat_flow_state.dart';

class PhotoReviewPage extends StatelessWidget {

  const PhotoReviewPage({super.key});

  Color get _borderColor => AppColors.foreground.withAlpha(20);
  Color get _mutedFg => AppColors.foreground.withAlpha(166);

  @override
  Widget build(BuildContext context) {
    final chatFlowCubit = context.read<ChatFlowCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: BlocBuilder<ChatFlowCubit, ChatFlowState>(
          builder: (context, state) {
            return state.maybeWhen(
              photoReview: (photoPath) {
                return Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 64.h, 24.w, 20.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: _borderColor, width: 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Fotoğraf Önizleme',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.foreground,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    // Photo preview area
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: AppColors.foreground.withAlpha(10), // muted/30 hissi
                        padding: EdgeInsets.all(24.w),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 520.w),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24.r), // rounded-3xl
                                    child: Image.file(
                                      File(photoPath),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  // ring
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24.r),
                                        border: Border.all(
                                          color: _borderColor.withAlpha(140), // ring-border/50 hissi
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // shadow feel (subtle)
                                  Positioned.fill(
                                    child: IgnorePointer(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withAlpha(18),
                                              blurRadius: 18,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Info + Buttons
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 24.h),
                      child: Column(
                        children: [
                          Text(
                            'Bu fotoğraf sohbetinize eşlik edecek. İsterseniz tekrar çekebilirsiniz.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _mutedFg,
                              fontSize: 13.sp,
                              height: 1.45,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 420.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 56.h,
                                  child: ElevatedButton(
                                    onPressed: chatFlowCubit.continueFromPhoto,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.onPrimary,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Devam Et',
                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56.h,
                                  child: OutlinedButton.icon(
                                    onPressed: chatFlowCubit.retakePhoto,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.foreground,
                                      side: BorderSide(color: _borderColor, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    icon: Icon(Icons.rotate_left_rounded, size: 20.sp, color: AppColors.foreground),
                                    label: Text(
                                      'Tekrar Çek',
                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}