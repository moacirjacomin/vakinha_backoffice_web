import 'package:shared_preferences/shared_preferences.dart';

import 'base_storage.dart';

class LocalStorage implements BaseStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();

  late SharedPreferences  prefs;

  Future<void> init() async {
    // Gets async settings
    prefs = await SharedPreferences.getInstance(); 
  }

  static LocalStorage getInstance() {
    return _instance;
  }

  // Setters 
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  // Getters
  int? getInt(String key) => prefs.getInt(key);

  bool? getBool(String key) => prefs.getBool(key);

  double? getDouble(String key) => prefs.getDouble(key);

  String? getString(String key) => prefs.getString(key);

  List<String>? getStringList(String key) => prefs.getStringList(key);

  // Others
  void clear() =>  prefs.clear();
  void remove(String key) => prefs.remove(key);
 
}

 