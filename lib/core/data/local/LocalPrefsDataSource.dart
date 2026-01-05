import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalPrefsDataSource {
  Future<bool> getOnboardingSeen();
  Future<void> setOnboardingSeen(bool value);
}

class LocalPrefsDataSourceImpl implements LocalPrefsDataSource {
  static const _kOnboardingSeen = 'onboarding_seen';

  final SharedPreferences prefs;
  LocalPrefsDataSourceImpl(this.prefs);

  @override
  Future<bool> getOnboardingSeen() async {
    return prefs.getBool(_kOnboardingSeen) ?? false;
  }

  @override
  Future<void> setOnboardingSeen(bool value) async {
    await prefs.setBool(_kOnboardingSeen, value);
  }
}