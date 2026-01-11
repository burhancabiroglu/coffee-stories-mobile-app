import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:coffeestories/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/build_widgets.dart';
import '../chat_flow/chat_flow_cubit.dart';
import '../chat_flow/chat_flow_state.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final ChatFlowCubit cubit;

  CameraController? _controller;
  bool _initializing = true;

  String _error = '';
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();

    cubit = context.read<ChatFlowCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initCamera();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    setState(() {
      _initializing = true;
      _error = '';
      _permissionDenied = false;
    });

    try {
      final cams = await availableCameras();
      final back = cams.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cams.isNotEmpty ? cams.first : throw StateError('No camera found'),
      );

      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();

      if (!mounted) return;
      setState(() {
        _controller?.dispose();
        _controller = controller;
        _initializing = false;
      });
    } on CameraException catch (e) {
      // Kamera izin / device / in-use vb.
      if (!mounted) return;

      final code = e.code.toLowerCase();
      final isDenied = code.contains('permission') || code.contains('access');
      setState(() {
        _permissionDenied = isDenied;
        _initializing = false;
        _error = _mapCameraError(e);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _permissionDenied = true;
        _initializing = false;
        _error = 'Kamera erişiminde bir hata oluştu. Demo fotoğraf kullanabilirsiniz.';
      });
    }
  }

  String _mapCameraError(CameraException e) {
    // Platforma göre code değişebiliyor; bu yüzden güvenli bir mapping.
    final code = e.code.toLowerCase();

    if (code.contains('permission')) {
      return 'Kamera erişimi reddedildi. Ayarlardan kamera izni vermeniz gerekmektedir.';
    }
    if (code.contains('notfound') || code.contains('no camera')) {
      return 'Kamera bulunamadı. Cihazınızda kamera olduğundan emin olun.';
    }
    if (code.contains('inuse') || code.contains('already')) {
      return 'Kamera kullanımda. Diğer uygulamaları kapatıp tekrar deneyin.';
    }
    return 'Kamera erişiminde bir hata oluştu. Demo fotoğraf kullanabilirsiniz.';
  }

  Future<void> _capture() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized || c.value.isTakingPicture) return;

    try {
      final file = await c.takePicture();
      if (!mounted) return;

      // Flow’a yaz: foto review state’ine geç.
      // (ChatFlowCubit içinde bunu photoReview’a emit edecek metodu çağıracağız.)
      cubit.onPhotoCaptured(file.path);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Fotoğraf çekilemedi. Tekrar deneyin veya demo fotoğraf kullanın.';
        _permissionDenied = false;
      });
    }
  }

  Future<void> _useMockPhoto() async {
    final path = await _generateMockPhotoFile();
    if (!mounted) return;
    cubit.onPhotoCaptured(path);
  }

  void _cancel() {
    // Burada “home’a dön” gibi navigasyonu UI yapmasın.
    // Flow cubit karar versin: restart mı, çıkış mı.
    cubit.cancelFlow();
  }

  Future<String> _generateMockPhotoFile() async {
    // 800x800 canvas: kahve hissi.
    const w = 800.0;
    const h = 800.0;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, w, h));

    // radial gradient background (kahve)
    final bgPaint = Paint()
      ..shader = ui.Gradient.radial(
        const Offset(w / 2, h / 2),
        400,
        [
          AppColors.primary,
          const Color(0xFF6B4226),
          const Color(0xFF4A2F1A),
        ],
        [0.0, 0.55, 1.0],
      );

    canvas.drawRect(const Rect.fromLTWH(0, 0, w, h), bgPaint);

    // cup circle
    final cupPaint = Paint()..color = const Color(0xFFD4C4B0);
    canvas.drawCircle(const Offset(w / 2, h / 2), 200, cupPaint);

    // emoji / icon text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '☕',
        style: TextStyle(fontSize: 80),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(w / 2 - textPainter.width / 2, h / 2 - textPainter.height / 2));

    final picture = recorder.endRecording();
    final image = await picture.toImage(w.toInt(), h.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/mock_coffee_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    // Bu page normalde sadece state.camera iken gösterilecek,
    // ama yine de güvenli olması için state’e bakabiliriz.
    return BlocBuilder<ChatFlowCubit, ChatFlowState>(
      builder: (context, state) {
        // Eğer flow camera değilse, boş çiz (parent zaten switch ediyor olmalı)
        final isCameraStep = state.maybeWhen(
          camera: () => true,
          orElse: () => false,
        );
        if (!isCameraStep) return const SizedBox.shrink();

        return Scaffold(
          backgroundColor: AppColors.foreground, // bg-foreground
          body: SafeArea(
            top: false,
            child: Stack(
              children: [
                Positioned.fill(child: buildCameraBody()),
                buildHeader(_cancel),
                if (_error.isEmpty) buildGuideFrame(),
                if (_error.isEmpty) buildWarmOverlay(),
                if (_error.isEmpty) buildBottomControls(_capture),
                if (_error.isEmpty) buildInfoText(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCameraBody() {
    if (_initializing) {
      return Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withAlpha(220)),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.photo_camera_outlined, size: 64.sp, color: Colors.white.withAlpha(120)),
                SizedBox(height: 16.h),
                Text(
                  'Kamera Erişilemedi',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  _error,
                  style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 13.sp, height: 1.45),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: PrimaryButton(
                    onTap: _useMockPhoto,
                    icon: Icons.image_outlined,
                    label: 'Demo Fotoğraf Kullan',
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: OutlinedButton(
                    onPressed: _cancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withAlpha(40), width: 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    ),
                    child: Text('Geri Dön', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ),
                ),

                if (_permissionDenied) ...[
                  SizedBox(height: 14.h),
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(18),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: Colors.white.withAlpha(30), width: 1),
                    ),
                    child: Text(
                      '💡 İpucu: Telefon ayarlarınızdan uygulama için Kamera iznini açabilirsiniz.',
                      style: TextStyle(color: Colors.white.withAlpha(180), fontSize: 12.sp, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    final c = _controller;
    if (c == null || !c.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: CameraPreview(c),
    );
  }


}
