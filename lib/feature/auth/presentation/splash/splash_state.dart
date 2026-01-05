import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

/// Splash akışı için explicit ve niyet bazlı state'ler.
/// Navigation kararı UI/router tarafında yapılır.
@freezed
sealed class SplashState with _$SplashState {
  /// İlk durum: minimum süre + bootstrap bekleniyor
  const factory SplashState.loading() = SplashLoading;

  /// Token geçerli, direkt home'a gidilecek
  const factory SplashState.goHome() = SplashGoHome;

  /// Token yok/geçersiz + onboarding görülmemiş
  const factory SplashState.goOnboarding() = SplashGoOnboarding;

  /// Token yok/geçersiz + onboarding görülmüş
  const factory SplashState.goLogin() = SplashGoLogin;

  /// Zorunlu update gibi özel durumlar (ileride)
  const factory SplashState.forceUpdate() = SplashForceUpdate;
}