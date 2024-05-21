import 'dart:convert';

import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accessTokenKey = 'accessToken';
  static const String checkAccessKey = 'checkAccess';
  static const String userIdKey = 'user_id';
  static late SharedPreferences _prefs;
  static const String phoneNumberKey = 'phone_number';
  static const String addressKey = 'address_user';
  static const String avatarImagePathKey = 'avatarImagePath';
  static const String roleIDKey = 'role_id';
  static const String employeeCodeKey = 'employee_code';

  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveNotifications(
      List<Map<String, String>> notifications) async {
    final List<String> encodedNotifications = notifications.map((notification) {
      return jsonEncode(notification);
    }).toList();
    await _prefs.setStringList('notifications', encodedNotifications);
  }

  static Future<List<Map<String, String>>> loadNotifications() async {
    final List<String>? encodedNotifications =
        _prefs.getStringList('notifications');
    if (encodedNotifications != null) {
      return encodedNotifications.map((encodedNotification) {
        return jsonDecode(encodedNotification) as Map<String, String>;
      }).toList();
    }
    return [];
  }

  static Future<List<Map<String, String>>> getNotifications() async {
    final List<String>? encodedNotifications =
        _prefs.getStringList('notifications');
    if (encodedNotifications != null) {
      return encodedNotifications.map((encodedNotification) {
        return jsonDecode(encodedNotification) as Map<String, String>;
      }).toList();
    }
    return [];
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

  static void setRoleID(int roleID) {
    _prefs.setInt(roleIDKey, roleID);
  }

  static int? get roleID {
    return _prefs.getInt(roleIDKey);
  }

  static int? get employeeCode {
    return _prefs.getInt(employeeCodeKey);
  }

  static void setEmployeeCode(int employeeCode) {
    _prefs.setInt(employeeCodeKey, employeeCode);
  }

  static bool get isLogin => token?.isNotEmpty ?? false;

  static bool get isAccessed => _prefs.getBool(checkAccessKey) ?? false;

  static set isAccessed(bool value) => _prefs.setBool(checkAccessKey, value);

  static void removeSeason() {
    print('Removing user session token: $token');
    print('Removing user session user_id: $user_id');
    print('Removing user session user_id: $employeeCode');
    // print('Removing user session avatar: $avatarImagePath');
    _prefs.remove(accessTokenKey);
    _prefs.remove(checkAccessKey);
    _prefs.remove(userIdKey);
    _prefs.remove(employeeCodeKey);
    // _prefs.remove(avatarImagePathKey);
    print('User session token and user_id removed successfully.');
  }

  static Future<void> setPhoneNumber(String phoneNumber) async {
    await _prefs.setString(phoneNumberKey, phoneNumber);
  }

  static String? get phoneNumber {
    return _prefs.getString(phoneNumberKey);
  }

  static Future<void> setAdress_User(String address_user) async {
    await _prefs.setString(addressKey, address_user);
  }

  static String? get address_user {
    return _prefs.getString(addressKey);
  }

  static String encrypt(String data) {
    // Implement actual encryption logic here
    return data;
  }

  static String decrypt(String encryptedData) {
    // Implement actual decryption logic here
    return encryptedData;
  }

  // // Thêm hàm setAvatarImagePath để lưu đường dẫn ảnh vào SharedPreferences
  // static Future<void> setAvatarImagePath(String imagePath) async {
  //   await _prefs.setString(avatarImagePathKey, imagePath);
  // }

  // // Thêm hàm avatarImagePath để lấy đường dẫn ảnh từ SharedPreferences
  // static String? get avatarImagePath {
  //   return _prefs.getString(avatarImagePathKey);
  // }

  static Future<void> setAvatarImagePath(int user_id, String imagePath) async {
    await _prefs.setString('$avatarImagePathKey$user_id', imagePath);
  }

  static String? getAvatarImagePath(int user_id) {
    return _prefs.getString('$avatarImagePathKey$user_id');
  }

  static Future<List<int>?> getSavedUserIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userIds = prefs.getStringList('savedUserIds');
    return userIds?.map((userId) => int.tryParse(userId) ?? 0).toList();
  }

  static Future<AppUsersModel?> getSavedUser(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('user_$userId');
    if (userDataString != null) {
      final Map<String, dynamic> userData = jsonDecode(userDataString);
      return AppUsersModel.fromJson(userData);
    }
    return null;
  }

  static Future<void> saveUser(AppUsersModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userIds = prefs.getStringList('savedUserIds');
    userIds ??= [];
    userIds.add(user.user_id.toString());
    await prefs.setStringList('savedUserIds', userIds);
    await prefs.setString('user_${user.user_id}', jsonEncode(user.toJson()));
  }

  static Future<void> removeUser(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userIds = prefs.getStringList('savedUserIds');
    if (userIds != null) {
      userIds.remove(userId.toString());
      await prefs.setStringList('savedUserIds', userIds);
    }
    await prefs.remove('user_$userId');
  }
}
