import 'package:shared_preferences/shared_preferences.dart';

class SpUtil{

  set(String key, Object value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (value is int) {
      sp.setInt(key, value);
    } else if (value is String) {
      sp.setString(key, value);
    } else if (value is bool) {
      sp.setBool(key, value);
    } else if (value is double) {
      sp.setDouble(key, value);
    } else if (value is List<String>) {
      sp.setStringList(key, value);
    }
  }

  get(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }


  remove(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
    sp.clear();
  }
}