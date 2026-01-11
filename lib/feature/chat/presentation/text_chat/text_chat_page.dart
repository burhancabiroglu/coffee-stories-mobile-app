import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/chat_message.dart';
import '../../data/model/sender.dart';
import '../../widgets/typing_dots.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui';


class TextChatPage extends StatefulWidget {
  const TextChatPage({
    super.key,
    this.photoPath,
  });

  final String? photoPath; // şimdilik sadece “var/yok” için

  @override
  State<TextChatPage> createState() => _TextChatPageState();
}

class _TextChatPageState extends State<TextChatPage> {
  late final ChatFlowCubit chatFlowCubit;
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();

  late final List<ChatMessage> _messages;
  bool _isTyping = false;
  int _questionCount = 0;

  Timer? _typingTimer;
  Timer? _endSuggestTimer;

  Color get _borderColor => AppColors.foreground.withAlpha(20);
  Color get _mutedFg => AppColors.foreground.withAlpha(166);
  Color get _mutedBg => AppColors.foreground.withAlpha(12);
  Color get _cardBg => Colors.white; // AppColors.card yoksa beyaz tercih (senin sistemde card = white)

  LinearGradient get _aiGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4FD1C5), // ai-cyan
          Color(0xFF3B82F6), // ai-blue
          Color(0xFF8B5CF6), // ai-purple
          Color(0xFFEC4899), // ai-pink
        ],
      );

  Widget _gradientText(String text, TextStyle style) {
    return ShaderMask(
      shaderCallback: (bounds) => _aiGradient.createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _messages = [
      ChatMessage(
        id: '1',
        text: 'Merhaba! Bugün nasılsınız? Paylaşmak istediğiniz bir şey var mı?',
        sender: Sender.ai,
        timestamp: DateTime.now(),
      ),
    ];
    chatFlowCubit = context.read<ChatFlowCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom(jump: true));
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _endSuggestTimer?.cancel();
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool jump = false}) {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position.maxScrollExtent;
    if (jump) {
      _scrollController.jumpTo(pos);
    } else {
      _scrollController.animateTo(
        pos,
        duration: 260.ms,
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _send() {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: text,
        sender: Sender.user,
        timestamp: DateTime.now(),
      ));
      _inputController.clear();
      _isTyping = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    _typingTimer?.cancel();
    _typingTimer = Timer(1500.ms, () {
      final aiResponses = [
        'Anlıyorum. Bunu duyduğuma üzüldüm. Daha fazla anlatmak ister misiniz?',
        'Bu çok ilginç. Bu durum sizi nasıl hissettiriyor?',
        'Paylaştığınız için teşekkür ederim. Size nasıl eşlik edebilirim?',
        'Dinliyorum. Devam edin lütfen.',
      ];

      final rnd = Random();
      final newCount = _questionCount + 1;

      setState(() {
        _questionCount = newCount;
        _messages.add(ChatMessage(
          id: (DateTime.now().microsecondsSinceEpoch + 1).toString(),
          text: aiResponses[rnd.nextInt(aiResponses.length)],
          sender: Sender.ai,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

      if (newCount >= 3) {
        _endSuggestTimer?.cancel();
        _endSuggestTimer = Timer(2000.ms, () {
          setState(() {
            _messages.add(ChatMessage(
              id: (DateTime.now().microsecondsSinceEpoch + 2).toString(),
              text: 'Bu güzel sohbet için teşekkür ederim. Bugünlük burada bitirmek ister misiniz?',
              sender: Sender.ai,
              timestamp: DateTime.now(),
            ));
          });

          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        });
      }
    });
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final canSend = _inputController.text.trim().isNotEmpty && !_isTyping;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header (Settings diline yakın)
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 14.h),
              decoration: BoxDecoration(
                color: _cardBg.withAlpha(245),
                border: Border(bottom: BorderSide(color: _borderColor, width: 1)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: chatFlowCubit.cancelFlow,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.foreground.withAlpha(12),
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
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 34.w,
                          height: 34.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withAlpha(170),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.local_cafe_outlined,
                            size: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'AI Genie',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.foreground,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            SizedBox(height: 2.h),
                            _isTyping
                                ? _gradientText(
                                    'yazıyor...',
                                    Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w700,
                                        ) ??
                                        TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    'çevrimiçi',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: _mutedFg,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.photoPath != null) ...[
                    SizedBox(
                      width: 44.w,
                      height: 44.w,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          // TODO: photo preview sheet
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_outlined,
                            size: 20.sp,
                            color: _mutedFg,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  if (_questionCount > 0 && _questionCount <= 3)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _mutedBg,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: _borderColor, width: 1),
                      ),
                      child: Text(
                        '$_questionCount/3',
                        style: TextStyle(
                          color: _mutedFg,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                itemCount: _messages.length + (_isTyping ? 1 : 0) + 1, // + bottom spacer
                itemBuilder: (context, i) {
                  // bottom spacer
                  final typingIndex = _messages.length;
                  final spacerIndex = _messages.length + (_isTyping ? 1 : 0);

                  if (_isTyping && i == typingIndex) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18.r),
                                    topRight: Radius.circular(18.r),
                                    bottomLeft: Radius.circular(10.r),
                                    bottomRight: Radius.circular(18.r),
                                  ),
                                  gradient: _aiGradient,
                                ),
                              ).animate().fadeIn(duration: 120.ms),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.r),
                                topRight: Radius.circular(18.r),
                                bottomLeft: Radius.circular(10.r),
                                bottomRight: Radius.circular(18.r),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: _cardBg,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18.r),
                                      topRight: Radius.circular(18.r),
                                      bottomLeft: Radius.circular(10.r),
                                      bottomRight: Radius.circular(18.r),
                                    ),
                                    border: Border.all(color: _borderColor, width: 1),
                                  ),
                                  child: const TypingDots(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 160.ms);
                  }

                  if (i == spacerIndex) {
                    return SizedBox(height: 4.h);
                  }

                  final m = _messages[i];
                  final isUser = m.sender == Sender.user;

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 0.75.sw), // max-w-[75%]
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isUser ? AppColors.primary : _cardBg,
                          borderRadius: isUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(18.r),
                                  topRight: Radius.circular(18.r),
                                  bottomLeft: Radius.circular(18.r),
                                  bottomRight: Radius.circular(10.r),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(18.r),
                                  topRight: Radius.circular(18.r),
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(18.r),
                                ),
                          border: isUser ? null : Border.all(color: _borderColor, width: 1),
                          boxShadow: isUser
                              ? null
                              : [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(10),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              m.text,
                              style: TextStyle(
                                color: isUser ? AppColors.onPrimary : AppColors.foreground,
                                fontSize: 14.sp,
                                height: 1.35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              _formatTime(m.timestamp),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: isUser
                                    ? AppColors.onPrimary.withAlpha(180)
                                    : _mutedFg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 180.ms)
                      .slideY(begin: 0.05, end: 0, duration: 180.ms);
                },
              ),
            ),

            // Input area
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: _borderColor, width: 1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) {},
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 4,
                          style: TextStyle(
                            color: AppColors.foreground,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Mesajınızı yazın...',
                            hintStyle: TextStyle(color: _mutedFg, fontSize: 14.sp),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 44.w,
                        height: 44.w,
                        child: ElevatedButton(
                          onPressed: canSend ? _send : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                            shape: const CircleBorder(),
                          ),
                          child: Icon(Icons.send_rounded, size: 18.sp),
                        ),
                      ),
                    ],
                  ),

                  if (_questionCount >= 3) ...[
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: chatFlowCubit.finishChat,
                      child: Text(
                        'Sohbeti Bitir',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary.withAlpha(140),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
