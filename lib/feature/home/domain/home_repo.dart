import 'recent_chat.dart';

abstract class HomeRepository {
  Future<int> getCreditBalance();
  Future<List<RecentChat>> getRecentChats({int limit = 20});
}