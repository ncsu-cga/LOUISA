import 'package:shared_preferences/shared_preferences.dart';

void setSharedPreference(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}