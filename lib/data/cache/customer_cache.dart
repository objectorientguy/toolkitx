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

  void setHashCode(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.hashcode, string);
  }

  void setUserId(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.userId, string);
  }

  void setUserId2(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.userId2, string);
  }

  void setClientDataKey(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.clientDataKey, string);
  }

  void setTimeZoneName(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.timeZoneName, string);
  }

  void setIsLoggedIn(String key, bool boolValue) async {
    await sharedPreferences.setBool(CacheKeys.isLoggedIn, boolValue);
  }

  void setIsLanguageSelected(String key, bool boolValue) async {
    await sharedPreferences.setBool(CacheKeys.isLanguageSelected, boolValue);
  }

  void setIsTimeZoneSelected(String key, bool boolValue) async {
    await sharedPreferences.setBool(CacheKeys.isTimeZoneSelected, boolValue);
  }

  void setIsDateFormatSelected(String key, bool boolValue) async {
    await sharedPreferences.setBool(CacheKeys.isDateFormatSelected, boolValue);
  }

  void setClientImage(String key, String string) async {
    await sharedPreferences.setString(CacheKeys.clientImage, string);
  }

  Future<String?> getCustomerDateFormat(String key) async {
    return sharedPreferences.getString(CacheKeys.dateFormatKey);
  }

  Future<String?> getClientDataKey(String key) async {
    return sharedPreferences.getString(CacheKeys.clientDataKey);
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

  Future<bool?> getIsLoggedIn(String key) async {
    return sharedPreferences.getBool(CacheKeys.isLoggedIn);
  }

  Future<bool?> getIsLanguageSelected(String key) async {
    return sharedPreferences.getBool(CacheKeys.isLanguageSelected);
  }

  Future<bool?> getIsTimeZoneSelected(String key) async {
    return sharedPreferences.getBool(CacheKeys.isTimeZoneSelected);
  }

  Future<bool?> getIsDateFormatSelected(String key) async {
    return sharedPreferences.getBool(CacheKeys.isDateFormatSelected);
  }

  Future<String?> getClientImage(String key) async {
    return sharedPreferences.getString(CacheKeys.isLoggedIn);
  }

  Future<String?> getHashCode(String key) async {
    return sharedPreferences.getString(CacheKeys.hashcode);
  }

  Future<String?> getUserId(String key) async {
    return sharedPreferences.getString(CacheKeys.userId);
  }

  Future<String?> getUserId2(String key) async {
    return sharedPreferences.getString(CacheKeys.userId2);
  }

  Future<String?> getTimeZoneName(String key) async {
    return sharedPreferences.getString(CacheKeys.timeZoneName);
  }

  Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
