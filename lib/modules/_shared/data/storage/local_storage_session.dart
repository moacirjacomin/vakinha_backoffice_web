import 'dart:html';

import 'base_storage.dart';

class LocalStorageSession implements BaseStorage {
  LocalStorageSession._();
  static final LocalStorageSession _instance = LocalStorageSession._();

  static LocalStorageSession getInstance() {
    return _instance;
  }

  String getData(String key) => window.sessionStorage[key] ?? '';

  void setData(String key, String value) => window.sessionStorage[key] = value;

  @override
  void clear() => window.sessionStorage.clear();

  @override
  bool? getBool(String key) => window.sessionStorage[key] as bool;

  @override
  double? getDouble(String key) => window.sessionStorage[key] as double;

  @override
  int? getInt(String key) => window.sessionStorage[key] as int;

  @override
  String? getString(String key) => window.sessionStorage[key]  ;

  @override
  List<String>? getStringList(String key) => window.sessionStorage[key] as List<String>;

  @override
  void remove(String key) => window.sessionStorage.remove(key);

  @override
  Future<void> setBool(String key, bool value) => Future(() {
        window.sessionStorage[key] = value.toString();
      });

  @override
  Future<void> setDouble(String key, double value) => Future(() {
        window.sessionStorage[key] = value.toString();
      });

  @override
  Future<void> setInt(String key, int value) => Future(() {
        window.sessionStorage[key] = value.toString();
      });

  @override
  Future<void> setString(String key, String value) => Future(() {
        window.sessionStorage[key] = value.toString();
      });

  @override
  Future<void> setStringList(String key, List<String> value) => Future(() {
        window.sessionStorage[key] = value.toString();
      });
}
