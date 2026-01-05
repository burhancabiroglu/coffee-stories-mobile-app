import 'package:equatable/equatable.dart';

class AppFlowState extends Equatable {
  final bool isBootstrapped;   // initial load bitti mi?
  final bool onboardingSeen;
  final bool isAuthed;

  const AppFlowState({
    required this.isBootstrapped,
    required this.onboardingSeen,
    required this.isAuthed,
  });

  AppFlowState copyWith({
    bool? isBootstrapped,
    bool? onboardingSeen,
    bool? isAuthed,
  }) {
    return AppFlowState(
      isBootstrapped: isBootstrapped ?? this.isBootstrapped,
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
      isAuthed: isAuthed ?? this.isAuthed,
    );
  }

  @override
  List<Object?> get props => [isBootstrapped, onboardingSeen, isAuthed];

  static const initial = AppFlowState(
    isBootstrapped: false,
    onboardingSeen: false,
    isAuthed: false,
  );
}
