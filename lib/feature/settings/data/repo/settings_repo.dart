import '../model/settings_user.dart';

abstract class SettingsRepository {
  Future<SettingsUser> getCurrentUser();        // name/email/initials
  Future<int> getCreditBalance();               // credits
  Future<void> logout();                        // logout
}


class SettingsRepositoryDummy implements SettingsRepository {
  SettingsRepositoryDummy({
    SettingsUser? user,
    int initialCredits = 250,
    Duration latency = const Duration(milliseconds: 400),
    bool throwOnLoggedOutReads = true,
  })  : _user = user ??
      const SettingsUser(
        displayName: 'Ali Kaya',
        email: 'ali@example.com',
        initials: 'AK',
      ),
        _credits = initialCredits,
        _latency = latency,
        _throwOnLoggedOutReads = throwOnLoggedOutReads;

  SettingsUser _user;
  int _credits;
  bool _loggedOut = false;

  final Duration _latency;
  final bool _throwOnLoggedOutReads;

  @override
  Future<SettingsUser> getCurrentUser() async {
    await Future.delayed(_latency);

    if (_loggedOut && _throwOnLoggedOutReads) {
      throw StateError('User is logged out');
    }

    return _user;
  }

  @override
  Future<int> getCreditBalance() async {
    await Future.delayed(_latency);

    if (_loggedOut && _throwOnLoggedOutReads) {
      throw StateError('User is logged out');
    }

    return _credits;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(_latency);
    _loggedOut = true;
  }

  // ---- Helpers (optional) for local testing ----

  /// Simulate purchasing credits
  void addCredits(int amount) {
    if (amount <= 0) return;
    _credits += amount;
  }

  /// Simulate user editing profile
  void setUser(SettingsUser user) {
    _user = user;
  }

  /// Simulate login again (useful in dev)
  void loginAgain({SettingsUser? user, int? credits}) {
    _loggedOut = false;
    if (user != null) _user = user;
    if (credits != null) _credits = credits;
  }
}