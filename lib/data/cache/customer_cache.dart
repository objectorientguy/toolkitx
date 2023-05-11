import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/cache/cache_keys.dart';

class CustomerCache {
  final SharedPreferences sharedPreferences;

  CustomerCache({required this.sharedPreferences});

  void setCustomerDateFormatString(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.dateFormatKey, string);
  }

  Future<String?> getCustomerDateFormat(String key) async {
    return sharedPreferences.getString(CacheKeys.dateFormatKey);
  }
}
