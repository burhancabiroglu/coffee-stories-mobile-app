import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_flow_state.dart';

class ChatFlowCubit extends Cubit<ChatFlowState> {
  ChatFlowCubit() : super(const ChatFlowState.camera());

  ChatStrategy? _strategy;
  String? _sessionId;
  String? _photoPath;

  /// Flow'u başlatır.
  /// Home tarafında kullanıcı text/voice seçtiğinde çağır.
  void start({
    required ChatStrategy strategy,
    String? sessionId,
  }) {
    _strategy = strategy;
    _sessionId = sessionId;
    _photoPath = null;

    // ileride: permission check / preload
    emit(const ChatFlowState.camera());
  }

  /// Kamera ekranından fotoğraf çekilince çağır.
  /// Fotoğraf önizleme adımına geçer.
  void onPhotoCaptured(String photoPath) {
    _photoPath = photoPath;
    emit(ChatFlowState.photoReview(photoPath: photoPath));
  }

  /// Fotoğraf önizlemeden devam edildiğinde çağır.
  /// Chat adımına geçer.
  void continueFromPhoto() {
    final strategy = _strategy;
    if (strategy == null) {
      emit(const ChatFlowState.error(message: 'Akış başlatılamadı. Lütfen tekrar deneyin.'));
      return;
    }

    emit(ChatFlowState.chat(strategy: strategy, sessionId: _sessionId));
  }

  /// Fotoğraf önizlemede "tekrar çek" ile kameraya döner.
  void retakePhoto() {
    _photoPath = null;
    emit(const ChatFlowState.camera());
  }

  /// Flow'dan çık (UI listener ile Home'a gider).
  void cancelFlow() {
    emit(const ChatFlowState.exitToHome());
  }

  /// Chat tamamlanınca result'a geç.
  void finishChat() {
    final strategy = _strategy;
    if (strategy == null) {
      emit(const ChatFlowState.error(message: 'Sohbet tamamlanamadı. Lütfen tekrar deneyin.'));
      return;
    }

    emit(ChatFlowState.result(strategy: strategy, sessionId: _sessionId));
  }

  /// Yeni sohbet için akışı başa sar (aynı strategy ile).
  void restart() {
    _photoPath = null;
    emit(const ChatFlowState.camera());
  }

  /// Hata state'i
  void fail(String message) {
    emit(ChatFlowState.error(message: message));
  }

  /// İleride lazım olursa: foto path'e erişim (örn. chat'e parametre olarak geçirmek).
  String? get photoPath => _photoPath;
}