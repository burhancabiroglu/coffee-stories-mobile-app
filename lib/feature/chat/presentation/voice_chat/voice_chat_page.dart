import 'dart:async';

import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/voice_chat.dart';
import '../../widgets/aurora_ring.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/rotating_aurora.dart';


class VoiceChatPage extends StatefulWidget {
  const VoiceChatPage({super.key});

  @override
  State<VoiceChatPage> createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends State<VoiceChatPage> {
  VoiceState voiceState = VoiceState.idle;
  final List<String> _transcript = ['Merhaba! Sizi dinliyorum...'];

  Timer? _t1;
  Timer? _t2;

  // Local “aurora” colors (sadece bu ekran için)
  static const _aiCyan = Color(0xFF22D3EE);
  static const _aiBlue = Color(0xFF3B82F6);
  static const _aiPurple = Color(0xFF8B5CF6);
  static const _aiPink = Color(0xFFF472B6);

  Color get _borderColor => AppColors.foreground.withAlpha(20);
  Color get _mutedFg => AppColors.foreground.withAlpha(166);

  @override
  void dispose() {
    _t1?.cancel();
    _t2?.cancel();
    super.dispose();
  }

  void _toggleVoice() {
    if (voiceState != VoiceState.idle) return;

    setState(() => voiceState = VoiceState.listening);

    _t1?.cancel();
    _t1 = Timer(3000.ms, () {
      setState(() {
        voiceState = VoiceState.speaking;
        _transcript.add('Anlıyorum, devam edin lütfen...');
      });

      _t2?.cancel();
      _t2 = Timer(2000.ms, () {
        setState(() => voiceState = VoiceState.idle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isActive = voiceState != VoiceState.idle;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // subtle background gradient like React: from background to muted/30
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background,
                      AppColors.foreground.withAlpha(10),
                    ],
                  ),
                ),
              ),
            ),

            Column(
              children: [
                // Header (simple, centered title, spacer)
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 56.h, 24.w, 12.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 44.w,
                        height: 44.w,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () {}, // todo: widget.onBack
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.foreground.withAlpha(16),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 18.sp,
                              color: AppColors.foreground,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sesli Sohbet',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.foreground,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 44.w, height: 44.w), // spacer
                    ],
                  ),
                ),

                // Main
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 18.h),
                    child: Column(
                      children: [
                        const Spacer(),

                        // Visualization
                        SizedBox(
                          width: 1.sw,
                          child: Center(
                            child: SizedBox(
                              width: 280.w,
                              height: 280.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Animated rings (active only)
                                  if (isActive) ...[
                                    AuroraRing(
                                      size: 210.w,
                                      opacity: 0.20,
                                      delay: 0.ms,
                                    ),
                                    AuroraRing(
                                      size: 245.w,
                                      opacity: 0.14,
                                      delay: 500.ms,
                                    ),
                                  ],

                                  // Center mic button
                                  _MicButton(
                                    state: voiceState,
                                    onTap: _toggleVoice,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Status text (with gradient for listening/speaking)
                        AnimatedSwitcher(
                          duration: 220.ms,
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, anim) => FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.15),
                                end: Offset.zero,
                              ).animate(anim),
                              child: child,
                            ),
                          ),
                          child: _buildStatus(),
                        ),

                        SizedBox(height: 26.h),

                        // Transcript
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(maxWidth: 520.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(140), // bg-card/50 hissi
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(color: _borderColor, width: 1),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 120.h),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(_transcript.length, (i) {
                                  final isFirst = i == 0;
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: i == _transcript.length - 1 ? 0 : 8.h),
                                    child: Text(
                                      _transcript[i],
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        height: 1.35,
                                        fontWeight: FontWeight.w600,
                                        color: isFirst ? _mutedFg : AppColors.foreground,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),

                // End call button
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: OutlinedButton.icon(
                      onPressed: () {}, // todo: widget.onComplete
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red.withAlpha(18),
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red.withAlpha(40), width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      ),
                      icon: Icon(Icons.call_end_rounded, size: 20.sp),
                      label: Text(
                        'Aramayı Bitir',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ).animate().fadeIn(duration: 220.ms, delay: 80.ms),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus() {
    switch (voiceState) {
      case VoiceState.idle:
        return Text(
          'Konuşmak için dokunun',
          key: const ValueKey('idle'),
          style: TextStyle(color: _mutedFg, fontSize: 14.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        );

      case VoiceState.listening:
        return GradientText(
          key: const ValueKey('listening'),
          text: 'Dinliyorum...',
          fontSize: 16.sp,
          gradient: const LinearGradient(colors: [_aiCyan, _aiBlue, _aiPurple]),
        );

      case VoiceState.speaking:
        return GradientText(
          key: const ValueKey('speaking'),
          text: 'Konuşuyorum...',
          fontSize: 16.sp,
          gradient: const LinearGradient(colors: [_aiPurple, _aiPink, _aiCyan]),
        );
    }
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({required this.state, required this.onTap});

  final VoiceState state;
  final VoidCallback onTap;

  static const _aiCyan = Color(0xFF22D3EE);
  static const _aiBlue = Color(0xFF3B82F6);
  static const _aiPurple = Color(0xFF8B5CF6);
  static const _aiPink = Color(0xFFF472B6);

  @override
  Widget build(BuildContext context) {
    final isIdle = state == VoiceState.idle;
    final isListening = state == VoiceState.listening;

    final baseColor = isIdle ? AppColors.primary : Colors.white;
    final iconColor = isIdle ? AppColors.onPrimary : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 220.ms,
        curve: Curves.easeOutCubic,
        width: 140.w,
        height: 140.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: baseColor,
          boxShadow: [
            if (!isIdle)
              BoxShadow(
                color: _aiCyan.withAlpha(80),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            if (!isIdle)
              BoxShadow(
                color: _aiPurple.withAlpha(40),
                blurRadius: 80,
                spreadRadius: 2,
              ),
            if (isIdle)
              BoxShadow(
                color: AppColors.primary.withAlpha(70),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // rotating aurora sheen (listening)
            if (isListening)
              Positioned.fill(
                child: ClipOval(
                  child: RotatingAurora(
                    opacity: 0.16,
                    duration: 3.seconds,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_aiCyan, _aiBlue, _aiPurple, _aiPink],
                    ),
                  ),
                ),
              ),
            Icon(Icons.mic_rounded, size: 56.sp, color: iconColor),
          ],
        ),
      ).animate().scaleXY(begin: 1, end: 0.96, duration: 80.ms).then().scaleXY(begin: 0.96, end: 1, duration: 120.ms),
    );
  }
}
