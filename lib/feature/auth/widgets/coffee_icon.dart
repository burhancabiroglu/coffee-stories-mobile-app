import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Splash'teki coffee ikon + titreşim + pulse dot (React karşılığı).
/// Not: Bu widget'i splash_page.dart içinde kullanabilirsin.
class CoffeeIcon extends StatelessWidget {
  final double? size;

  const CoffeeIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Coffee icon (wiggle)
        Icon(
          Icons.coffee,
          size: size ?? 80.w,
          color: Colors.white,
        )
            .animate(delay: 500.ms)
            .custom(
          duration: 2.seconds,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            // React: rotate [0, -5, 5, -5, 0]
            // 5 degrees ~= 0.087 radians
            final rotation = TweenSequence<double>([
              TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.087), weight: 1),
              TweenSequenceItem(tween: Tween(begin: -0.087, end: 0.087), weight: 1),
              TweenSequenceItem(tween: Tween(begin: 0.087, end: -0.087), weight: 1),
              TweenSequenceItem(tween: Tween(begin: -0.087, end: 0.0), weight: 1),
            ]).transform(value);

            return Transform.rotate(
              angle: rotation,
              child: child,
            );
          },
        ),

        // Pulse dot
        Positioned(
          top: -8,
          right: -8,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51), // 0.2 * 255 ≈ 51
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.2, 1.2),
            duration: 2.seconds,
            curve: Curves.easeInOut,
          )
              .fade(
            begin: 0.3,
            end: 0.6,
            duration: 2.seconds,
            curve: Curves.easeInOut,
          ),
        ),
      ],
    )
    // React: initial { scale: 0.8, opacity: 0 } -> animate { scale: 1, opacity: 1 }
        .animate()
        .scale(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1),
      duration: 600.ms,
      curve: Curves.easeOut,
    )
        .fadeIn(duration: 600.ms);
  }
}