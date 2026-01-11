import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../presentation/credit_purchase_state.dart';

class PackageTile extends StatelessWidget {
  const PackageTile({
    required this.package,
    required this.isSelected,
    required this.borderColor,
    required this.mutedFg,
    required this.accentSoft,
    required this.onTap,
  });

  final CreditPackage package;
  final bool isSelected;
  final Color borderColor;
  final Color mutedFg;
  final Color accentSoft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selectedBorder = AppColors.primary;
    final cardBg = isSelected ? AppColors.primary.withAlpha(13) /* primary/5 */ : AppColors.card;

    return InkWell(
      borderRadius: BorderRadius.circular(24.r), // rounded-2xl
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w), // p-5
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? selectedBorder : borderColor,
            width: 2, // border-2
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (package.popular)
              Positioned(
                top: -32.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.secondary, // warm beige pill
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'En Popüler',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.foreground,
                      ),
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: accentSoft, // bg-accent/30
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.auto_awesome, // Sparkles karşılığı
                        size: 24.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${package.credits} Kredi',
                          style: TextStyle(
                            fontSize: 16.sp, // text-lg
                            fontWeight: FontWeight.w700,
                            color: AppColors.foreground,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${package.approxChats} sohbet hakkı',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: mutedFg,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Right
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${package.priceText} ₺',
                          style: TextStyle(
                            fontSize: 18.sp, // text-xl
                            fontWeight: FontWeight.w800,
                            color: AppColors.foreground,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.foreground.withAlpha(80),
                          width: 2,
                        ),
                        color: isSelected ? AppColors.primary : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: isSelected
                          ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
