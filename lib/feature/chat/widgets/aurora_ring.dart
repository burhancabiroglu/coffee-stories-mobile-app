import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuroraRing extends StatelessWidget {
  const AuroraRing({
    required this.size,
    required this.opacity,
    required this.delay,
  });

  final double size;
  final double opacity;
  final Duration delay;

  static const _aiCyan = Color(0xFF22D3EE);
  static const _aiBlue = Color(0xFF3B82F6);
  static const _aiPurple = Color(0xFF8B5CF6);
  static const _aiPink = Color(0xFFF472B6);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [_aiCyan, _aiBlue, _aiPurple, _aiPink],
            stops: [0.0, 0.30, 0.60, 1.0],
          ),
        ),
      ),
    )
        .animate(delay: delay, onPlay: (c) => c.repeat())
        .fade(begin: opacity, end: 0, duration: 2.seconds, curve: Curves.easeInOut)
        .scaleXY(begin: 1, end: 1.35, duration: 2.seconds, curve: Curves.easeInOut);
  }
}
