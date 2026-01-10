import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/model/AppSessionSnapshot.dart';
import '../../core/data/repo/AppSessionRepository.dart';
import 'app_flow_state.dart';


class AppFlowCubit extends Cubit<AppFlowState> {
  final AppSessionRepository _sessionRepo;

  AppFlowCubit({required AppSessionRepository sessionRepo})
      : _sessionRepo = sessionRepo,
        super(AppFlowState.initial);

  /// App açılışında storage'dan onboarding/auth durumunu oku.
  ///
  /// Notlar:
  /// - `isBootstrapped` runtime flag’dir; storage’da tutulmaz.
  /// - `onboardingSeen` SharedPreferences gibi local storage’dan gelir.
  /// - `isAuthed` token varlığı/validliği üzerinden repo tarafından türetilir.
  Future<void> bootstrap() async {
    // idempotent: yanlışlıkla 2 kez çağrılsa da sorun çıkarmasın
    if (state.isBootstrapped) return;

    try {
      final AppSessionSnapshot snap = await _sessionRepo.loadStartupSnapshot();

      emit(
        state.copyWith(
          isBootstrapped: true,
          onboardingSeen: snap.onboardingSeen,
          isAuthed: true,// todo: snap.isAuthed,
        ),
      );
    } catch (_) {
      // Fail-safe: app açılışını kilitleme.
      emit(
        state.copyWith(
          isBootstrapped: true,
          onboardingSeen: false,
          isAuthed: false,
        ),
      );
    }
  }

  /// Onboarding tamamlandı (persist + state)
  Future<void> markOnboardingSeen() async {
    try {
      await _sessionRepo.markOnboardingSeen();
    } catch (_) {
      // ignore: UI akışını bloklama
    }

    emit(state.copyWith(onboardingSeen: true));
  }

  /// Auth state değişimi (persist + state)
  ///
  /// Not: Üretimde genellikle `signedInWithToken(token)` / `signOut()` kullanırsın.
  Future<void> setAuthed(bool value) async {
    if (value == state.isAuthed) return;

    if (!value) {
      try {
        await _sessionRepo.signOut();
      } catch (_) {
        // ignore
      }
      emit(state.copyWith(isAuthed: false));
      return;
    }

    // Token yazmadan "authed" yapmak genelde doğru değil;
    // ama mevcut akışı bozmamak için sadece state’i güncelliyoruz.
    emit(state.copyWith(isAuthed: true));
  }

  /// Tercih edilen giriş akışı: token yazıp authed yapmak.
  Future<void> signedInWithToken(String token) async {
    try {
      await _sessionRepo.setToken(token);
    } catch (_) {
      // ignore
    }
    emit(state.copyWith(isAuthed: true));
  }

  Future<void> signOut() async {
    try {
      await _sessionRepo.signOut();
    } catch (_) {
      // ignore
    }
    emit(state.copyWith(isAuthed: false));
  }
}