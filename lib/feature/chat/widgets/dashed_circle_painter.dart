
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Dashed circle painter (guide frame)
class DashedCirclePainter extends CustomPainter {
  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final radius = size.width / 2;
    final circumference = 2 * math.pi * radius;

    final dashCount = (circumference / (dashLength + gapLength)).floor();
    final step = 2 * math.pi / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * step;
      final sweepAngle = (dashLength / circumference) * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius - strokeWidth),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}