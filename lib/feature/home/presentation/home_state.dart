import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/recent_chat.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.ready({
    required int credits,
    required List<RecentChat> recentChats,
  }) = HomeReady;

  const factory HomeState.empty({
    required int credits,
  }) = HomeEmpty;

  const factory HomeState.error({
    required String message,
    @Default(0) int creditsFallback,
    @Default(<RecentChat>[]) List<RecentChat> recentChatsFallback,
  }) = HomeError;
}