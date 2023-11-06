import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_storage.dart';

class LocalStorageSecure implements BaseStorage {
  LocalStorageSecure._();
  static final LocalStorageSecure _instance = LocalStorageSecure._();
  final prefs = const FlutterSecureStorage();

  Future<void> init() async {}

  static LocalStorageSecure getInstance() {
    return _instance;
  }

  // Setters
  Future<void> setString(String key, String value) async {
    await prefs.write(key: key, value: value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await prefs.write(key: key, value: value.toString());
  }

  Future<void> setDouble(String key, double value) async {
    await prefs.write(key: key, value: value.toString());
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.write(key: key, value: value.toString());
  }

  Future<void> setInt(String key, int value) async {
    await prefs.write(key: key, value: value.toString());
  }

  // Getters
  int? getInt(String key) => prefs.read(key: key) as int?;

  bool? getBool(String key) => prefs.read(key: key) as bool?;

  double? getDouble(String key) => prefs.read(key: key) as double?;

  String? getString(String key) => prefs.read(key: key) as String?;

  List<String>? getStringList(String key) => prefs.read(key: key) as List<String>;

  // Others
  Future<void> delete(String key) async => await prefs.delete(key: key);

  Future<void> clear() async => await prefs.deleteAll();

  Future<Map<String, String>> getAll() async => await prefs.readAll();

  Future<bool> contains(String key)  async => await prefs.containsKey(key: key);
  
  @override
  void remove(String key) => prefs.delete(key: key);

}
