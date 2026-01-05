import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class OnboardingSlideData {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 380),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // React: scale 0 -> 1 (spring)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 450),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.30), // bg-accent/30
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.foreground,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.mutedForeground,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}