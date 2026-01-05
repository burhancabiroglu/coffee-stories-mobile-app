
import '../local/LocalPrefsDataSource.dart';
import '../local/SecureTokenDataSource.dart';
import '../model/AppSessionSnapshot.dart';

abstract class AppSessionRepository {
  Future<AppSessionSnapshot> loadStartupSnapshot();
  Future<void> markOnboardingSeen();
  Future<void> setToken(String token);
  Future<void> signOut();
}

class AppSessionRepositoryImpl implements AppSessionRepository {
  final LocalPrefsDataSource prefs;
  final SecureTokenDataSource tokens;

  AppSessionRepositoryImpl({
    required this.prefs,
    required this.tokens,
  });

  @override
  Future<AppSessionSnapshot> loadStartupSnapshot() async {
    final onboardingSeen = await prefs.getOnboardingSeen();
    final token = await tokens.readAccessToken();
    final isAuthed = token != null && token.isNotEmpty;

    return AppSessionSnapshot(
      onboardingSeen: onboardingSeen,
      isAuthed: isAuthed,
    );
  }

  @override
  Future<void> markOnboardingSeen() => prefs.setOnboardingSeen(true);

  @override
  Future<void> setToken(String token) => tokens.writeAccessToken(token);

  @override
  Future<void> signOut() async {
    await tokens.clear();
  }
}