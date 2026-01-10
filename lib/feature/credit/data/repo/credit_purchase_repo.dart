abstract class CreditPurchaseRepository {
  Future<int> getCreditBalance();

  /// App Store / Play Billing akışı burada yürür.
  /// Başarılı olursa yeni kredi bakiyesini döndürmek en temiz yol.
  Future<int> purchasePackage({
    required int packageId,
  });
}

/// Dummy / Fake implementation of CreditPurchaseRepository
///
/// - Network / Store bağlantısı yok
/// - Bellek içi kredi tutar
/// - purchasePackage çağrısında krediyi artırır
class CreditPurchaseRepositoryDummy implements CreditPurchaseRepository {
  CreditPurchaseRepositoryDummy({
    int initialCredits = 250,
    Duration latency = const Duration(milliseconds: 400),
  })  : _credits = initialCredits,
        _latency = latency;

  int _credits;
  final Duration _latency;

  @override
  Future<int> getCreditBalance() async {
    await Future.delayed(_latency);
    return _credits;
  }

  @override
  Future<int> purchasePackage({required int packageId}) async {
    await Future.delayed(_latency);

    final creditsToAdd = _creditsForPackage(packageId);
    if (creditsToAdd <= 0) {
      throw StateError('Geçersiz paket');
    }

    _credits += creditsToAdd;
    return _credits;
  }

  /// React / UI tarafındaki paketlerle birebir eşleşir
  int _creditsForPackage(int packageId) {
    switch (packageId) {
      case 1:
        return 100;
      case 2:
        return 250;
      case 3:
        return 500;
      case 4:
        return 1000;
      default:
        return 0;
    }
  }

  // ---- Test / Dev yardımcıları ----

  /// Krediyi manuel set etmek için (debug)
  void setCredits(int value) {
    _credits = value;
  }

  /// Krediyi sıfırlamak için
  void reset() {
    _credits = 0;
  }
}