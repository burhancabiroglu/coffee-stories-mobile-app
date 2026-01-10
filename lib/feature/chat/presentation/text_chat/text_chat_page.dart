import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/model/chat_message.dart';
import '../../data/model/sender.dart';
import '../../widgets/typing_dots.dart';

import 'dart:async';
import 'dart:math';


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
              padding: EdgeInsets.fromLTRB(16.w, 56.h, 16.w, 14.h),
              decoration: BoxDecoration(
                color: _cardBg,
                border: Border(bottom: BorderSide(color: _borderColor, width: 1)),
              ),
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
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sohbet',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.foreground,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (_questionCount > 0) ...[
                          SizedBox(height: 2.h),
                          Text(
                            '$_questionCount/3 soru',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _mutedFg,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.photoPath != null)
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
                ],
              ),
            ),

            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: _cardBg,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: _borderColor, width: 1),
                        ),
                        child: const TypingDots(),
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
                          borderRadius: BorderRadius.circular(18.r),
                          border: isUser ? null : Border.all(color: _borderColor, width: 1),
                        ),
                        child: Text(
                          m.text,
                          style: TextStyle(
                            color: isUser ? AppColors.onPrimary : AppColors.foreground,
                            fontSize: 14.sp,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
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
                color: _cardBg,
                border: Border(top: BorderSide(color: _borderColor, width: 1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _mutedBg,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: _borderColor, width: 1),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: TextField(
                            controller: _inputController,
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) => _send(),
                            textInputAction: TextInputAction.send,
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
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 52.w,
                        height: 52.w,
                        child: ElevatedButton(
                          onPressed: canSend ? _send : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          ),
                          child: Icon(Icons.send_rounded, size: 18.sp),
                        ),
                      ),
                    ],
                  ),

                  if (_questionCount >= 3) ...[
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {}, // todo:widget.onComplete,
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

