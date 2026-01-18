import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/router/app_flow_cubit.dart';
import '../data/local/LocalPrefsDataSource.dart';
import '../data/local/SecureTokenDataSource.dart';
import '../data/repo/AppSessionRepository.dart';

final injector = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  injector.registerSingleton<SharedPreferences>(prefs);
  injector.registerSingleton<FlutterSecureStorage>(secureStorage);
  injector.registerLazySingleton<LocalPrefsDataSource>(() => LocalPrefsDataSourceImpl(injector()));
  injector.registerLazySingleton<SecureTokenDataSource>(() => SecureTokenDataSourceImpl(injector()));
  injector.registerLazySingleton<AppSessionRepository>(() => AppSessionRepositoryImpl(prefs: injector(), tokens: injector()));
  injector.registerLazySingleton<AppFlowCubit>(() => AppFlowCubit(sessionRepo: injector()));
}
