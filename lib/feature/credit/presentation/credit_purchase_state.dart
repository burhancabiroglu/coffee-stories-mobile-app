import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_purchase_state.freezed.dart';

@freezed
sealed class CreditPurchaseState with _$CreditPurchaseState {
  const factory CreditPurchaseState.loading() = CreditPurchaseLoading;

  const factory CreditPurchaseState.ready({
    required int currentCredits,
    required List<CreditPackage> packages,
    required int selectedPackageId,

    // UI flags
    @Default(false) bool isPurchasing,
    @Default(false) bool isWatchingAd,

    // Optional inline message (snackbar vs.)
    String? message,
  }) = CreditPurchaseReady;

  const factory CreditPurchaseState.error({
    required String message,
    @Default(0) int creditsFallback,
    @Default(<CreditPackage>[]) List<CreditPackage> packagesFallback,
    @Default(2) int selectedPackageIdFallback,
  }) = CreditPurchaseError;
}

/// UI widget’larında kullandığın modele uyumlu.
/// (Sende zaten `CreditPackage` widget var; aynı isimle kullanmak iyi.)
class CreditPackage {
  final int id;
  final int credits;
  final String priceText;
  final bool popular;

  const CreditPackage({
    required this.id,
    required this.credits,
    required this.priceText,
    required this.popular,
  });

  int get approxChats => (credits / 10).round();
}