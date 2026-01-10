import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:coffeestories/app/router/route_names.dart';
import 'package:coffeestories/app/theme/app_colors.dart';
import 'package:coffeestories/feature/chat/presentation/conversation_end/conversation_end_page.dart';
import 'package:coffeestories/feature/chat/presentation/error/chat_error_page.dart';
import 'package:coffeestories/feature/chat/presentation/photo_review/photo_review_page.dart';
import 'package:coffeestories/feature/chat/presentation/text_chat/text_chat_page.dart';
import 'package:coffeestories/feature/chat/presentation/camera/camera_page.dart';
import 'package:coffeestories/feature/chat/presentation/voice_chat/voice_chat_page.dart';

import 'chat_flow_cubit.dart';
import 'chat_flow_state.dart';
import 'chat_flow_args.dart';

class ChatFlowPage extends StatefulWidget {
  const ChatFlowPage({super.key});

  @override
  State<ChatFlowPage> createState() => _ChatFlowPageState();
}

class _ChatFlowPageState extends State<ChatFlowPage> {
  late final ChatFlowCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChatFlowCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      final args = extra is ChatFlowArgs ? extra : const ChatFlowArgs.text();
      cubit.start(strategy: args.entry, sessionId: args.previousSessionId);
      if(args.entry == ChatStrategy.previous) {
        cubit.continueFromPhoto();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: BlocListener<ChatFlowCubit, ChatFlowState>(
          listenWhen: (prev, next) => next.maybeWhen(
            exitToHome: () => true,
            orElse: () => false,
          ),
          listener: (context, state) { context.go(RouteNames.home); },
          child: BlocBuilder<ChatFlowCubit, ChatFlowState>(
            builder: (context, state) {
              return state.when(
                loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                camera: () => const CameraPage(),
                chat: (strategy, sessionId) {
                  switch (strategy) {
                    case ChatStrategy.text:
                      return TextChatPage();
                    case ChatStrategy.voice:
                      return const VoiceChatPage();
                    case ChatStrategy.previous:
                      return TextChatPage();
                  }
                },
                result: (strategy, sessionId) => const ConversationEndPage(),
                photoReview: (photoPath) => const PhotoReviewPage(),
                exitToHome: () => const SizedBox.shrink(),
                error: (message) => ErrorStub(message: message, onRetry: cubit.restart),
              );
            },
          ),
        ),
      ),
    );
  }
}
