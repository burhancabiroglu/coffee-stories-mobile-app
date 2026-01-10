import 'package:coffeestories/feature/home/data/repo/home_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/router/app_flow_cubit.dart';
import '../../feature/credit/data/repo/credit_purchase_repo.dart';
import '../../feature/credit/data/service/rewarded_ad_service.dart';
import '../../feature/settings/data/repo/settings_repo.dart';
import '../data/local/LocalPrefsDataSource.dart';
import '../data/local/SecureTokenDataSource.dart';
import '../data/repo/AppSessionRepository.dart';


final injector = GetIt.instance;

/// Composition Root
/// - External bağımlılıklar (SharedPreferences, SecureStorage)
/// - DataSource'lar
/// - Repository'ler
/// - App-level Cubit'ler
Future<void> configureDependencies() async {
  // 3rd party / external
  final prefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  // External singletons
  if (!injector.isRegistered<SharedPreferences>()) {
    injector.registerSingleton<SharedPreferences>(prefs);
  }
  if (!injector.isRegistered<FlutterSecureStorage>()) {
    injector.registerSingleton<FlutterSecureStorage>(secureStorage);
  }

  // DataSources
  if (!injector.isRegistered<LocalPrefsDataSource>()) {
    injector.registerLazySingleton<LocalPrefsDataSource>(
      () => LocalPrefsDataSourceImpl(injector<SharedPreferences>()),
    );
  }
  if (!injector.isRegistered<SecureTokenDataSource>()) {
    injector.registerLazySingleton<SecureTokenDataSource>(
      () => SecureTokenDataSourceImpl(injector<FlutterSecureStorage>()),
    );
  }

  // Repositories
  if (!injector.isRegistered<AppSessionRepository>()) {
    injector.registerLazySingleton<AppSessionRepository>(
      () => AppSessionRepositoryImpl(
        prefs: injector<LocalPrefsDataSource>(),
        tokens: injector<SecureTokenDataSource>(),
      ),
    );
  }

  if (!injector.isRegistered<HomeRepository>()) {
    injector.registerLazySingleton<HomeRepository>(() => HomeRepositoryDummy());
  }

  // Credit Purchase / Ads (Dummy implementations for now)
  if (!injector.isRegistered<CreditPurchaseRepository>()) {
    injector.registerLazySingleton<CreditPurchaseRepository>(
      () => CreditPurchaseRepositoryDummy(initialCredits: 250),
    );
  }

  if (!injector.isRegistered<RewardedAdService>()) {
    injector.registerLazySingleton<RewardedAdService>(
      () => RewardedAdServiceDummy(),
    );
  }

  // Settings repository (Dummy for now)
  if (!injector.isRegistered<SettingsRepository>()) {
    injector.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryDummy(),
    );
  }

  // Cubits
  // AppFlowCubit her app run’da fresh instance olsun diye factory
  if (!injector.isRegistered<AppFlowCubit>()) {
    injector.registerLazySingleton<AppFlowCubit>(
      () => AppFlowCubit(sessionRepo: injector<AppSessionRepository>()),
    );
  }
}
