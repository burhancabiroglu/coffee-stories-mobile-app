import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.loading() = SplashLoading;
  const factory SplashState.ready() = SplashReady;
  const factory SplashState.forceUpdate() = SplashForceUpdate;
}