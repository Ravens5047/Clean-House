import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accessTokenKey = 'accessToken';
  static const String checkAccessKey = 'checkAccess';
  static const String userIdKey = 'user_id';
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

  static void setUserId(int user_id) {
    _prefs.setInt(userIdKey, user_id);
  }

  static int? get user_id {
    return _prefs.getInt(userIdKey);
  }

  static bool get isLogin => token?.isNotEmpty ?? false;

  static bool get isAccessed => _prefs.getBool(checkAccessKey) ?? false;

  static set isAccessed(bool value) => _prefs.setBool(checkAccessKey, value);

  static void removeSeason() {
    print('Removing user session token: $token');
    print('Removing user session user_id: $user_id');
    _prefs.remove(accessTokenKey);
    _prefs.remove(checkAccessKey);
    print('User session token and user_id removed successfully.');
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
