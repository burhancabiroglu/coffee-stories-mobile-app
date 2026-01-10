import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_state.dart';

/// Route extra olarak taşınır
class ChatFlowArgs {
  final ChatStrategy entry;

  /// Daha önce yapılmış bir sohbetten giriliyorsa
  /// ilgili session id
  final String? previousSessionId;

  const ChatFlowArgs({
    required this.entry,
    this.previousSessionId,
  });

  /// Güvenli varsayılan
  const ChatFlowArgs.text()
      : entry = ChatStrategy.text,
        previousSessionId = null;

  const ChatFlowArgs.voice()
      : entry = ChatStrategy.voice,
        previousSessionId = null;

  const ChatFlowArgs.previous({required String id})
      : entry = ChatStrategy.previous,
        previousSessionId = id;
}
