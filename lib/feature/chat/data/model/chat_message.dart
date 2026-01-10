import 'sender.dart';

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  final String id;
  final String text;
  final Sender sender;
  final DateTime timestamp;
}