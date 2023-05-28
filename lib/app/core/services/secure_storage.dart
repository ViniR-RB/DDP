import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  SecureStorage();
  readAll() {
    return _storage.readAll();
  }

  read(String key) {
    _storage.read(key: key);
  }

  delete(String key) {
    _storage.delete(key: key);
  }

  write(String key, String value) {
    _storage.write(key: key, value: value);
  }
}
