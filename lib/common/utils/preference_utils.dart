import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String? getString(String key) {
    return _prefsInstance?.getString(key);
  }

  static void setString(String key, String value) {
    _prefsInstance?.setString(key, value);
  }

  static List<String> getStringList(String key, [List<String>? defValue]) {
    if (_prefsInstance?.getStringList(key) == null) {
      setStringList(key, defValue ?? []);
    }
    return (_prefsInstance?.getStringList(key))!;
  }

  static void setStringList(String key, List<String> value) {
    _prefsInstance?.setStringList(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static void setBool(String key, bool value) {
    _prefsInstance?.setBool(key, value);
  }
}
