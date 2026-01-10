import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/credit_purchase_repo.dart';
import '../data/service/rewarded_ad_service.dart';
import 'credit_purchase_state.dart';


class CreditPurchaseCubit extends Cubit<CreditPurchaseState> {
  final CreditPurchaseRepository repo;
  final RewardedAdService ads;

  CreditPurchaseCubit({
    required this.repo,
    required this.ads,
  })  : super(const CreditPurchaseState.loading());

  /// Ekran açılışında:
  /// - credits çek
  /// - paketleri hazırla (şimdilik local)
  /// - selected default
  Future<void> load() async {
    emit(const CreditPurchaseState.loading());

    try {
      final credits = await repo.getCreditBalance();

      // Şimdilik local packages (React’teki ile birebir)
      const packages = <CreditPackage>[
        CreditPackage(id: 1, credits: 100, priceText: '29.99', popular: false),
        CreditPackage(id: 2, credits: 250, priceText: '59.99', popular: true),
        CreditPackage(id: 3, credits: 500, priceText: '99.99', popular: false),
        CreditPackage(id: 4, credits: 1000, priceText: '169.99', popular: false),
      ];

      emit(CreditPurchaseState.ready(
        currentCredits: credits,
        packages: packages,
        selectedPackageId: 2,
      ));
    } catch (e) {
      emit(CreditPurchaseState.error(message: _mapError(e)));
    }
  }

  void selectPackage(int packageId) {
    state.maybeWhen(
      ready: (currentCredits, packages, selectedId, isPurchasing, isWatchingAd, message) {
        // invalid selection guard
        final exists = packages.any((p) => p.id == packageId);
        if (!exists) return;

        emit(CreditPurchaseState.ready(
          currentCredits: currentCredits,
          packages: packages,
          selectedPackageId: packageId,
          isPurchasing: isPurchasing,
          isWatchingAd: isWatchingAd,
          message: message,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> purchaseSelected() async {
    final snapshot = state;

    await snapshot.maybeWhen(
      ready: (currentCredits, packages, selectedId, isPurchasing, isWatchingAd, message) async {
        if (isPurchasing || isWatchingAd) return;

        emit(CreditPurchaseState.ready(
          currentCredits: currentCredits,
          packages: packages,
          selectedPackageId: selectedId,
          isPurchasing: true,
          isWatchingAd: isWatchingAd,
          message: null,
        ));

        try {
          final newCredits = await repo.purchasePackage(packageId: selectedId);

          emit(CreditPurchaseState.ready(
            currentCredits: newCredits,
            packages: packages,
            selectedPackageId: selectedId,
            isPurchasing: false,
            isWatchingAd: false,
            message: 'Satın alma başarılı. Krediler güncellendi.',
          ));
        } catch (e) {
          emit(CreditPurchaseState.ready(
            currentCredits: currentCredits,
            packages: packages,
            selectedPackageId: selectedId,
            isPurchasing: false,
            isWatchingAd: false,
            message: _mapError(e),
          ));
        }
      },
      orElse: () async {
        // Not ready → ignore
      },
    );
  }

  Future<void> watchAdToEarn() async {
    final snapshot = state;

    await snapshot.maybeWhen(
      ready: (currentCredits, packages, selectedId, isPurchasing, isWatchingAd, message) async {
        if (isPurchasing || isWatchingAd) return;

        emit(CreditPurchaseState.ready(
          currentCredits: currentCredits,
          packages: packages,
          selectedPackageId: selectedId,
          isPurchasing: false,
          isWatchingAd: true,
          message: null,
        ));

        try {
          final rewardCredits = await ads.showRewardedAdAndGetRewardCredits();
          final newCredits = currentCredits + rewardCredits;

          // Burada “local optimistic update” yaptık.
          // Eğer backend ile sync istiyorsan: repo.syncCredits(newCredits) gibi bir çağrı eklenebilir.
          emit(CreditPurchaseState.ready(
            currentCredits: newCredits,
            packages: packages,
            selectedPackageId: selectedId,
            isPurchasing: false,
            isWatchingAd: false,
            message: '+$rewardCredits kredi kazandın!',
          ));
        } catch (e) {
          emit(CreditPurchaseState.ready(
            currentCredits: currentCredits,
            packages: packages,
            selectedPackageId: selectedId,
            isPurchasing: false,
            isWatchingAd: false,
            message: _mapError(e),
          ));
        }
      },
      orElse: () async {},
    );
  }

  void clearMessage() {
    state.maybeWhen(
      ready: (currentCredits, packages, selectedId, isPurchasing, isWatchingAd, message) {
        if (message == null) return;
        emit(CreditPurchaseState.ready(
          currentCredits: currentCredits,
          packages: packages,
          selectedPackageId: selectedId,
          isPurchasing: isPurchasing,
          isWatchingAd: isWatchingAd,
          message: null,
        ));
      },
      orElse: () {},
    );
  }

  String _mapError(Object e) {
    return 'Bir sorun oluştu. Lütfen tekrar deneyin.';
  }
}