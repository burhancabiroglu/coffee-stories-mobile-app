import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/settings_user.dart';
import '../../data/repo/settings_repo.dart';
import 'settings_state.dart';


class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repo;

  SettingsCubit({required SettingsRepository repo})
      : _repo = repo,
        super(const SettingsState.loading());

  /// Settings açılışında:
  /// - loading
  /// - user + credits paralel
  /// - ready veya error
  Future<void> load() async {
    emit(const SettingsState.loading());

    try {
      final results = await Future.wait([
        _repo.getCurrentUser(),
        _repo.getCreditBalance(),
      ]);

      final user = results[0] as SettingsUser;
      final credits = results[1] as int;

      emit(SettingsState.ready(
        displayName: user.displayName,
        email: user.email,
        initials: user.initials,
        credits: credits,
      ));
    } catch (e) {
      emit(SettingsState.error(
        message: _mapError(e),
      ));
    }
  }

  Future<void> refresh() => load();

  /// Logout aksiyonu:
  /// - State ready iken `isLoggingOut=true` yapıp UI’da butonu disable edebilirsin
  /// - Başarılı olursa UI tarafında listener ile route değiştirirsin
  /// - Hata olursa error state’e düşürür
  Future<void> logout() async {
    final snapshot = state;

    // Ready değilsek logout denemesini yine de yapabiliriz ama genelde hazırken olur.
    emit(snapshot.maybeWhen(
      ready: (displayName, email, initials, credits, isLoggingOut) =>
          SettingsState.ready(
            displayName: displayName,
            email: email,
            initials: initials,
            credits: credits,
            isLoggingOut: true,
          ),
      orElse: () => const SettingsState.loading(),
    ));

    try {
      await _repo.logout();

      // Logout başarılı: cubit genelde bir “event” yayınlamaz.
      // UI `BlocListener` ile bu success’i yakalamak için 2 yol:
      // 1) ayrı bir state: SettingsState.loggedOut()
      // 2) Cubit stream/event (side effect) — ben burada 1’i seçiyorum:
      //
      // Ama state dosyasında loggedOut yok; eğer istersen ekleyelim.
      //
      // Şimdilik: tekrar loading bırakıyorum; UI logout sonrası zaten route değiştirip bu sayfayı kapatacak.
      emit(const SettingsState.loading());
    } catch (e) {
      // Mevcut user/credits bilgilerini kaybetmemek için fallback dolduralım.
      final fallback = snapshot.maybeWhen(
        ready: (displayName, email, initials, credits, _) => (
        displayName,
        email,
        initials,
        credits
        ),
        error: (_, dn, em, ini, cr) => (dn, em, ini, cr),
        orElse: () => ('', '', '', 0),
      );

      emit(SettingsState.error(
        message: _mapError(e),
        displayNameFallback: fallback.$1,
        emailFallback: fallback.$2,
        initialsFallback: fallback.$3,
        creditsFallback: fallback.$4,
      ));
    }
  }

  /// Home’dan kredi güncellenince Settings’e de yansıtmak istersen:
  void setCredits(int credits) {
    state.when(
      loading: () => emit(SettingsState.ready(
        displayName: '',
        email: '',
        initials: '',
        credits: credits,
      )),
      ready: (displayName, email, initials, _, isLoggingOut) => emit(
        SettingsState.ready(
          displayName: displayName,
          email: email,
          initials: initials,
          credits: credits,
          isLoggingOut: isLoggingOut,
        ),
      ),
      error: (message, dn, em, ini, _,) => emit(
        SettingsState.error(
          message: message,
          displayNameFallback: dn,
          emailFallback: em,
          initialsFallback: ini,
          creditsFallback: credits,
        ),
      ),
    );
  }

  String _mapError(Object e) {
    return 'Bir sorun oluştu. Lütfen tekrar deneyin.';
  }
}