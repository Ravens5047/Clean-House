import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accessTokenKey = 'accessToken';
  static const String checkAccessKey = 'checkAccess';
  static late SharedPreferences _prefs;

  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    final encryptedToken = encrypt(token);
    await _prefs.setString(accessTokenKey, encryptedToken);
  }

  static String? get token {
    String? encryptedToken = _prefs.getString(accessTokenKey);
    return encryptedToken != null ? decrypt(encryptedToken) : null;
  }

  static set token(String? token) {
    String? encryptedToken = token != null ? encrypt(token) : null;
    _prefs.setString(accessTokenKey, encryptedToken ?? '');
  }

  static bool get isLogin => token?.isNotEmpty ?? false;

  static bool get isAccessed => _prefs.getBool(checkAccessKey) ?? false;

  static set isAccessed(bool value) => _prefs.setBool(checkAccessKey, value);

  static void removeSeason() {
    _prefs.remove(accessTokenKey);
    _prefs.remove(checkAccessKey);
  }

  static String encrypt(String data) {
    // Implement actual encryption logic here
    return data;
  }

  static String decrypt(String encryptedData) {
    // Implement actual decryption logic here
    return encryptedData;
  }
}
