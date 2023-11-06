abstract class BaseStorage {
  // Setters
  Future<void> setString(String key, String value);

  Future<void> setStringList(String key, List<String> value);

  Future<void> setDouble(String key, double value);

  Future<void> setBool(String key, bool value);

  Future<void> setInt(String key, int value);

  // Getters
  int? getInt(String key);

  bool? getBool(String key);

  double? getDouble(String key);

  String? getString(String key);

  List<String>? getStringList(String key);

  // Others
  void clear();
  void remove(String key);
}
