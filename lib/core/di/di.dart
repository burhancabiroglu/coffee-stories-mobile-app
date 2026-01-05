import 'package:coffeestories/feature/home/data/home_repo_impl.dart';
import 'package:coffeestories/feature/home/domain/home_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/router/app_flow_cubit.dart';
import '../data/local/LocalPrefsDataSource.dart';
import '../data/local/SecureTokenDataSource.dart';
import '../data/repo/AppSessionRepository.dart';


final getIt = GetIt.instance;

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
  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(prefs);
  }
  if (!getIt.isRegistered<FlutterSecureStorage>()) {
    getIt.registerSingleton<FlutterSecureStorage>(secureStorage);
  }

  // DataSources
  if (!getIt.isRegistered<LocalPrefsDataSource>()) {
    getIt.registerLazySingleton<LocalPrefsDataSource>(
      () => LocalPrefsDataSourceImpl(getIt<SharedPreferences>()),
    );
  }
  if (!getIt.isRegistered<SecureTokenDataSource>()) {
    getIt.registerLazySingleton<SecureTokenDataSource>(
      () => SecureTokenDataSourceImpl(getIt<FlutterSecureStorage>()),
    );
  }

  // Repositories
  if (!getIt.isRegistered<AppSessionRepository>()) {
    getIt.registerLazySingleton<AppSessionRepository>(
      () => AppSessionRepositoryImpl(
        prefs: getIt<LocalPrefsDataSource>(),
        tokens: getIt<SecureTokenDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryDummy());
  }

  // Cubits
  // AppFlowCubit her app run’da fresh instance olsun diye factory
  if (!getIt.isRegistered<AppFlowCubit>()) {
    getIt.registerFactory<AppFlowCubit>(
      () => AppFlowCubit(sessionRepo: getIt<AppSessionRepository>()),
    );
  }
}
