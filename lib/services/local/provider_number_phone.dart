import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }
}
