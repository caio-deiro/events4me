import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService(this.storage);

  /// Read a value
  Future<String?> storageRead({required String key}) async {
    return storage.read(key: key);
  }

  /// Write a value
  Future<void> storageWrite({
    required String key,
    required String value,
  }) async {
    await storage.write(key: key, value: value);
  }

  /// Delete a data
  Future<void> storageDelete({required String key}) async {
    await storage.delete(key: key);
  }

  /// checking whether the storage contains a key
  Future<bool> storageContainsKey({required String key}) async {
    return await storage.containsKey(key: key);
  }
}
