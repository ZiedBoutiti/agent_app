
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

 // call this method from iniState() function of mainApp().
  static init() async {
    _prefs = await SharedPreferences.getInstance();

    return _prefs;
  }

  //sets
  static  setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static  setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static  setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static  setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static setStringList(String key, List<String> value) async =>
      await _prefs!.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs!.getBool(key);

  static double? getDouble(String key) => _prefs!.getDouble(key);

  static int? getInt(String key) => _prefs!.getInt(key);

  static String? getString(String key) => _prefs!.getString(key);

  static List<String>? getStringList(String key) => _prefs!.getStringList(key);

  //deletes..
  static Future<bool>? remove(String key) async => await _prefs!.remove(key);

  static Future<bool>? clear() async => await _prefs!.clear();
}