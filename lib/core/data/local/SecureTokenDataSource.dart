import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureTokenDataSource {
  Future<String?> readAccessToken();
  Future<void> writeAccessToken(String token);
  Future<void> clear();
}

class SecureTokenDataSourceImpl implements SecureTokenDataSource {
  static const _kAccessToken = 'access_token';
  final FlutterSecureStorage storage;

  SecureTokenDataSourceImpl(this.storage);

  @override
  Future<String?> readAccessToken() => storage.read(key: _kAccessToken);

  @override
  Future<void> writeAccessToken(String token) =>
      storage.write(key: _kAccessToken, value: token);

  @override
  Future<void> clear() => storage.delete(key: _kAccessToken);
}