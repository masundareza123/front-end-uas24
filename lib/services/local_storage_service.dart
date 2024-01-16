import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> clearStorage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      return;

    }
  }

  Future<void> setString(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      return;

    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
    } catch (e) {
      return;

    }
  }

  Future<void> setDouble(String key, double value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(key, value);
    } catch (e) {
      return;

    }
  }

  Future<void> setBool(String key, bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (e) {
      return;
    }
  }

  Future<String?> getString(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(key);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<int?> getInt(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getInt(key);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<double?> getDouble(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getDouble(key);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> getBool(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getBool(key);

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<void> removeValue(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      return;

    }
  }
}
