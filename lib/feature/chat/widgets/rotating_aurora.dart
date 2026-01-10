import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RotatingAurora extends StatelessWidget {
  const RotatingAurora({
    required this.gradient,
    required this.opacity,
    required this.duration,
  });

  final Gradient gradient;
  final double opacity;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation(0), // placeholder, we animate via flutter_animate
      builder: (context, child) => child!,
      child: Opacity(
        opacity: opacity,
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
        ),
      )
          .animate(onPlay: (c) => c.repeat())
          .rotate(begin: 0, end: 1, duration: duration, curve: Curves.linear),
    );
  }
}
