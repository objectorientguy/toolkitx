import 'package:shared_preferences/shared_preferences.dart';

class CustomerCache {
  Future setCustomerDateFormatString(String key, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, string);
  }

  Future<String?> getCustomerDateFormatString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? string = prefs.getString(key);
    return string;
  }
}
