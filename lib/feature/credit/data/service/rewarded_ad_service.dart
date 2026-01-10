import 'dart:math';

abstract class RewardedAdService {
  /// Reward döndüğünde kaç kredi kazanıldığını verir.
  Future<int> showRewardedAdAndGetRewardCredits();
}

/// Dummy / Fake RewardedAdService
///
/// - Gerçek reklam göstermez
/// - Gecikme ile kullanıcı reklam izlemiş gibi davranır
/// - Rastgele veya sabit kredi ödülü döndürür
class RewardedAdServiceDummy implements RewardedAdService {
  RewardedAdServiceDummy({
    this.minReward = 10,
    this.maxReward = 30,
    this.simulatedWatchTime = const Duration(seconds: 2),
    this.failureRate = 0.0,
    int? seed,
  }) : _random = seed == null ? Random() : Random(seed);

  /// Minimum kazanılacak kredi
  final int minReward;

  /// Maksimum kazanılacak kredi
  final int maxReward;

  /// Reklam izleme süresi simülasyonu
  final Duration simulatedWatchTime;

  /// 0.0 → hiç hata yok
  /// 0.2 → %20 ihtimalle reklam başarısız
  final double failureRate;

  final Random _random;

  @override
  Future<int> showRewardedAdAndGetRewardCredits() async {
    await Future.delayed(simulatedWatchTime);

    if (failureRate > 0 && _random.nextDouble() < failureRate) {
      throw StateError('Reklam izlenemedi');
    }

    if (maxReward <= minReward) return minReward;

    final reward = minReward + _random.nextInt((maxReward - minReward) + 1);
    return reward;
  }
}
