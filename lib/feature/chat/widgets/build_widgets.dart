import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashed_circle_painter.dart';


Color get _overlayText => Colors.white.withAlpha(220);
Color get _overlayTextMuted => Colors.white.withAlpha(170);


Widget buildBottomControls(VoidCallback capture) {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 72.h,
    child: Center(
      child: GestureDetector(
        onTap: capture,
        child: Container(
          width: 82.w,
          height: 82.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: 140.ms,
            width: 66.w,
            height: 66.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.foreground, width: 4),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildHeader(VoidCallback cancel) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Padding(
      padding: EdgeInsets.fromLTRB(24.w, 56.h, 24.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kahve Fotoğrafı',
                    style: TextStyle(color: _overlayText, fontSize: 20.sp, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Fincanınızın fotoğrafını çekin',
                    style: TextStyle(color: _overlayTextMuted, fontSize: 13.sp, height: 1.2),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 44.w,
            height: 44.w,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: cancel,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(18),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.close_rounded, size: 22.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildInfoText() {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 18.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        'Fincanınızı daire içine yerleştirin ve fotoğrafı çekin',
        style: TextStyle(color: _overlayTextMuted, fontSize: 13.sp, height: 1.25),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget buildWarmOverlay() {
  return Positioned.fill(
    child: IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withAlpha(26),
              Colors.transparent,
              AppColors.primary.withAlpha(52),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildGuideFrame() {
  return Positioned.fill(
    child: IgnorePointer(
      child: Center(
        child: Container(
          width: 260.w,
          height: 260.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(90),
              width: 3,
              style: BorderStyle.solid, // Flutter dashed yok; dashed için custom painter kullanırız
            ),
          ),
          child: CustomPaint(
            painter: DashedCirclePainter(
              color: Colors.white.withAlpha(90),
              strokeWidth: 3,
              dashLength: 10,
              gapLength: 8,
            ),
          ),
        ),
      ),
    ),
  );
}
