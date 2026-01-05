
import 'package:coffeestories/feature/home/domain/recent_chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repo;

  HomeCubit({required HomeRepository repo})
      : _repo = repo,
        super(const HomeState.loading());

  /// Home açılışında çağrılacak.
  /// - önce loading
  /// - sonra credits + recentChats (paralel)
  /// - empty / ready ayrımı
  Future<void> load() async {
    emit(const HomeState.loading());

    try {
      final results = await Future.wait([
        _repo.getCreditBalance(),
        _repo.getRecentChats(limit: 20),
      ]);

      final credits = results[0] as int;
      final chats = results[1] as List;

      final recentChats = chats.cast<RecentChat>();

      if (recentChats.isEmpty) {
        emit(HomeState.empty(credits: credits));
        return;
      }

      emit(HomeState.ready(
        credits: credits,
        recentChats: recentChats,
      ));
    } catch (e) {
      emit(HomeState.error(
        message: _mapError(e),
      ));
    }
  }

  /// Pull-to-refresh veya tekrar deneme için.
  Future<void> refresh() => load();

  /// İlerde kredi satın alma sonrası “optimistic update” için.
  void setCredits(int credits) {
    state.when(
      loading: () => emit(HomeState.ready(credits: credits, recentChats: const [])),
      ready: (c, chats) => emit(HomeState.ready(credits: credits, recentChats: chats)),
      empty: (c) => emit(HomeState.empty(credits: credits)),
      error: (msg, creditsFallback, chatsFallback) => emit(
        HomeState.ready(credits: credits, recentChats: chatsFallback),
      ),
    );
  }

  String _mapError(Object e) {
    // Şimdilik basit. İleride DioException vs. mapleyebiliriz.
    return 'Bir sorun oluştu. Lütfen tekrar deneyin.';
  }
}