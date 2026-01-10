import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_flow_state.freezed.dart';

enum ChatStrategy { text, voice }

@freezed
sealed class ChatFlowState with _$ChatFlowState {
  const factory ChatFlowState.loading() = ChatFlowLoading;

  const factory ChatFlowState.camera() = ChatFlowCamera;

  /// camera sonrası fotoğraf önizleme
  const factory ChatFlowState.photoReview({
    required String photoPath,
  }) = ChatFlowPhotoReview;

  /// camera sonrası (strategy seçilmiş olmalı)
  const factory ChatFlowState.chat({
    required ChatStrategy strategy,
    String? sessionId,
  }) = ChatFlowChat;

  const factory ChatFlowState.result({
    required ChatStrategy strategy,
    String? sessionId,
  }) = ChatFlowResult;

  /// Flow'dan çıkıp ana sayfaya dönmek için (UI tarafı listener ile navigation yapar)
  const factory ChatFlowState.exitToHome() = ChatFlowExitToHome;

  const factory ChatFlowState.error({
    required String message,
  }) = ChatFlowError;
}