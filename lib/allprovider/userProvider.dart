import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  Map<String, dynamic> _user = {};
  bool _authenticated = false;
  String get toekn => _token;
  Map<String, dynamic> get user => _user;
  bool get authenticated => _authenticated;

  void setUser(Map<String, dynamic> userData, String token) {
    _user = userData;
    _token = token;
    _authenticated = true;
    notifyListeners();
  }

  void clearUser() {
    _user = {};
    _token = '';
    _authenticated = false;
    notifyListeners();
  }
}
