import '../domain/home_repo.dart';
import '../domain/recent_chat.dart';

class HomeRepositoryDummy implements HomeRepository {
  @override
  Future<int> getCreditBalance() async {
    // Simüle network latency
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return 250;
  }

  @override
  Future<List<RecentChat>> getRecentChats({int limit = 20}) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return const <RecentChat>[
      RecentChat(
        id: 1,
        title: 'Akşam Sohbeti',
        date: '2 Ocak 2026',
        preview: 'Bugün hava çok güzeldi...',
      ),
      RecentChat(
        id: 2,
        title: 'Sabah Kahvesi',
        date: '1 Ocak 2026',
        preview: 'Yeni yılın ilk günü...',
      ),
      RecentChat(
        id: 3,
        title: 'Düşünceler',
        date: '31 Aralık 2025',
        preview: 'Yılbaşı gecesi düşünceleri...',
      ),
    ];
  }
}
