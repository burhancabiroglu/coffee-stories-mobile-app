import 'dart:async';

import 'package:camera/camera.dart';
import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:coffeestories/core/data/mock/coffee_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

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

  // --- Coffee AI – Light Twilight (local to this screen) ---
  static const bool _useLightTwilight = true;

  // Background gradient (refined AI Twilight + Coffee)
  Color get _bgTop => const Color(0xFFF6F1EB);
  Color get _bgMid => const Color(0xFFEFE5D8);
  Color get _bgBottom => const Color(0xFFEAF1F6);

  // Text
  Color get _fg => AppColors.foreground;

  Color get _muted => AppColors.foreground.withAlpha(166);

  // Glass surfaces
  Color get _glassBg => Colors.white.withAlpha(230); // ~0.90
  Color get _glassBorder => Colors.black.withAlpha(12); // ~0.05

  // Accents
  static const Color _aiCyan = Color(0xFF5EC6E8);
  static const Color _coffee = Color(0xFF8B5A3C);

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
        orElse: () =>
        cams.isNotEmpty ? cams.first : throw StateError('No camera found'),
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
        _error =
        'Kamera erişiminde bir hata oluştu. Demo fotoğraf kullanabilirsiniz.';
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
        _error =
        'Fotoğraf çekilemedi. Tekrar deneyin veya demo fotoğraf kullanın.';
        _permissionDenied = false;
      });
    }
  }

  Future<void> _useMockPhoto() async {
    final path = await generateMockPhotoFile(getTemporaryDirectory());
    if (!mounted) return;
    cubit.onPhotoCaptured(path);
  }

  void _cancel() {
    // Burada “home’a dön” gibi navigasyonu UI yapmasın.
    // Flow cubit karar versin: restart mı, çıkış mı.
    cubit.cancelFlow();
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
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: _useLightTwilight
                  ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_bgTop, _bgMid, _bgBottom],
              )
                  : null,
              color: _useLightTwilight ? null : AppColors.background,
            ),
            child: SafeArea(
              top: false,
              child: Stack(
                children: [
                  Positioned.fill(child: buildCameraBody()),

                  // Soft tint over camera preview for legibility
                  if (_error.isEmpty)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _bgTop.withAlpha(70),
                                Colors.transparent,
                                const Color(0xFF8B5A3C).withAlpha(35),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  _buildHeaderLight(),
                  if (_error.isEmpty) _buildGuideFrameLight(),
                  if (_error.isEmpty) _buildBottomControlsLight(),
                  if (_error.isEmpty) _buildInfoTextLight(),
                ],
              ),
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
          valueColor: AlwaysStoppedAnimation<Color>(_coffee),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420.w),
            child: Container(
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: _glassBg,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: _glassBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(14),
                    blurRadius: 36,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Camera icon with subtle radial AI glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                _aiCyan.withAlpha(40),
                                Colors.transparent,
                              ],
                              center: Alignment.center,
                              radius: 0.85,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 68.w,
                        height: 68.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _coffee.withAlpha(20),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.photo_camera_outlined, size: 34.sp,
                            color: _coffee),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Kamera Erişilemedi',
                    style: TextStyle(color: _fg,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    _error,
                    style: TextStyle(
                        color: _muted, fontSize: 13.sp, height: 1.45),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),

                  // Primary CTA: AI cyan → coffee
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [_aiCyan, _coffee],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _aiCyan.withAlpha(90),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _useMockPhoto,
                        icon: Icon(Icons.image_outlined, size: 20.sp,
                            color: Colors.white),
                        label: Text(
                          'Demo Fotoğraf Kullan',
                          style: TextStyle(fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Secondary
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: OutlinedButton(
                      onPressed: _cancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _fg,
                        side: BorderSide(color: _coffee.withAlpha(60),
                            width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius
                            .circular(16.r)),
                      ),
                      child: Text('Geri Dön', style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),

                  if (_permissionDenied) ...[
                    SizedBox(height: 14.h),
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: _aiCyan.withAlpha(14),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: _aiCyan.withAlpha(50),
                            width: 1),
                      ),
                      child: Text(
                        '💡 İpucu: Telefon ayarlarınızdan uygulama için Kamera iznini açabilirsiniz.',
                        style: TextStyle(color: _muted,
                            fontSize: 12.sp,
                            height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
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

  Widget _buildHeaderLight() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 56.h, 16.w, 12.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: _glassBg,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: _glassBorder, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kahve Fotoğrafı',
                      style: TextStyle(color: _fg,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Fincanınızın fotoğrafını çekin',
                      style: TextStyle(
                          color: _muted, fontSize: 12.sp, height: 1.25),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 44.w,
                height: 44.w,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: _cancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _coffee.withAlpha(14),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.close_rounded, size: 22.sp, color: _fg),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideFrameLight() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: Container(
            width: 260.w,
            height: 260.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withAlpha(120), width: 3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControlsLight() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 64.h,
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: _capture,
          child: Container(
            width: 82.w,
            height: 82.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: _coffee.withAlpha(60), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _fg.withAlpha(80), width: 3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTextLight() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 18.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: _glassBg,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _glassBorder, width: 1),
            ),
            child: Text(
              'Fincanınızı daire içine yerleştirin ve fotoğrafı çekin',
              style: TextStyle(color: _muted, fontSize: 12.sp, height: 1.25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}