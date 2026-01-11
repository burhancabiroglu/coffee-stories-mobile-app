import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

Future<String> generateMockPhotoFile(Future<Directory> temporaryDirectory) async {
  return _generateMockPhotoFile(temporaryDirectory);
}

Future<String> _generateMockPhotoFile(Future<Directory> temporaryDirectory) async {
  // 800x800 canvas: kahve hissi.
  const w = 800.0;
  const h = 800.0;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, w, h));

  // Background: Coffee AI – Light Twilight
  // Base vertical gradient (warm → slightly cool)
  final baseBg = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(0, h),
      [
        const Color(0xFFF6F1EB), // warm off-white
        const Color(0xFFEFE5D8), // coffee-beige
        const Color(0xFFEAF1F6), // very light twilight
      ],
      [0.0, 0.55, 1.0],
    );
  canvas.drawRect(const Rect.fromLTWH(0, 0, w, h), baseBg);

  // Subtle coffee vignette (dark edges, soft center)
  final vignette = Paint()
    ..shader = ui.Gradient.radial(
      const Offset(w * 0.55, h * 0.50),
      520,
      [
        Colors.transparent,
        const Color(0xFF8B5A3C).withAlpha(24),
        const Color(0xFF4A2F1A).withAlpha(70),
      ],
      [0.0, 0.68, 1.0],
    );
  canvas.drawRect(const Rect.fromLTWH(0, 0, w, h), vignette);

  // AI twilight accent (top-left soft glow)
  final aiGlow = Paint()
    ..shader = ui.Gradient.radial(
      const Offset(w * 0.25, h * 0.20),
      420,
      [
        const Color(0xFF5EC6E8).withAlpha(32),
        Colors.transparent,
      ],
      [0.0, 1.0],
    );
  canvas.drawRect(const Rect.fromLTWH(0, 0, w, h), aiGlow);

  // Cup surface: warm ceramic with soft radial shading
  final cupShader = Paint()
    ..shader = ui.Gradient.radial(
      const Offset(w / 2 - 40, h / 2 - 50),
      260,
      [
        const Color(0xFFF7F2EA),
        const Color(0xFFE7DCCF),
        const Color(0xFFD4C4B0),
      ],
      [0.0, 0.55, 1.0],
    );
  canvas.drawCircle(const Offset(w / 2, h / 2), 220, cupShader);

  // Very subtle rim line
  final rimPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..color = const Color(0xFF3D2817).withAlpha(18);
  canvas.drawCircle(const Offset(w / 2, h / 2), 220, rimPaint);

  // Soft shadow under cup area to add depth
  final shadowPaint = Paint()
    ..color = Colors.black.withAlpha(18)
    ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 18);
  canvas.drawCircle(const Offset(w / 2, h / 2 + 18), 210, shadowPaint);
  // Redraw cup surface on top of shadow
  canvas.drawCircle(const Offset(w / 2, h / 2), 220, cupShader);
  canvas.drawCircle(const Offset(w / 2, h / 2), 220, rimPaint);

  // Small cup icon in the center (minimal, premium)
  final cupShadow = Paint()
    ..color = Colors.black.withAlpha(28)
    ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 6);
  canvas.drawCircle(const Offset(w / 2, h / 2 + 10), 22, cupShadow);

  final textPainter = TextPainter(
    text: TextSpan(
      text: '☕',
      style: TextStyle(
        fontSize: 56,
        color: const Color(0xFF3D2817).withAlpha(210),
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();

  textPainter.paint(
    canvas,
    Offset(
      w / 2 - textPainter.width / 2,
      h / 2 - textPainter.height / 2 - 6,
    ),
  );

  // Subtle grain/noise overlay (very low opacity)
  final noise = Paint()..color = Colors.black.withAlpha(6);
  const step = 14;
  for (int y = 0; y < h; y += step) {
    for (int x = 0; x < w; x += step) {
      // deterministic pseudo-noise based on coordinates
      final v = ((x * 37 + y * 17) % 100);
      if (v < 18) {
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1.2, noise);
      }
    }
  }

  final picture = recorder.endRecording();
  final image = await picture.toImage(w.toInt(), h.toInt());
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  final dir = await temporaryDirectory;
  final file = File('${dir.path}/mock_coffee_${DateTime
      .now()
      .millisecondsSinceEpoch}.png');
  await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);
  return file.path;
}
