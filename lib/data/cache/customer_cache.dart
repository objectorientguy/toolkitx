import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/cache/cache_keys.dart';

class CustomerCache {
  final SharedPreferences sharedPreferences;

  CustomerCache({required this.sharedPreferences});

  void setCustomerDateFormatString(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.dateFormatKey, string);
  }

  void setLanguageSyncDate(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.languageSyncDate, string);
  }

  void setTimeZoneCode(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.timeZoneCode, string);
  }

  void setEncryptedEmail(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.encryptedEmail, string);
  }

  void setUserType(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.userType, string);
  }

  void setClientId(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.clientId, string);
  }

  void setApiKey(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.apiKey, string);
  }

  Future<String?> getCustomerDateFormat(String key) async {
    return sharedPreferences.getString(CacheKeys.dateFormatKey);
  }

  Future<String?> getLanguageSyncDate(String key) async {
    return sharedPreferences.getString(CacheKeys.languageSyncDate);
  }

  Future<String?> getTimeZoneCode(String key) async {
    return sharedPreferences.getString(CacheKeys.timeZoneCode);
  }

  Future<String?> getEncryptedEmail(String key) async {
    return sharedPreferences.getString(CacheKeys.encryptedEmail);
  }

  Future<String?> getUserType(String key) async {
    return sharedPreferences.getString(CacheKeys.userType);
  }

  Future<String?> getClientId(String key) async {
    return sharedPreferences.getString(CacheKeys.clientId);
  }

  Future<String?> getApiKey(String key) async {
    return sharedPreferences.getString(CacheKeys.apiKey);
  }
}
