import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = SettingsLoading;

  const factory SettingsState.ready({
    required String displayName,
    required String email,
    required String initials,
    required int credits,
    @Default(false) bool isLoggingOut,
  }) = SettingsReady;

  const factory SettingsState.error({
    required String message,
    // Error ekranında da user bilgisi gösterilebilsin diye fallback’ler
    @Default('') String displayNameFallback,
    @Default('') String emailFallback,
    @Default('') String initialsFallback,
    @Default(0) int creditsFallback,
  }) = SettingsError;
}