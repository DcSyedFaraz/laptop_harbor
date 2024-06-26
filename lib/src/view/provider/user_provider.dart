import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _contact = '';

  String get name => _name;
  String get contact => _contact;

  void updateUserData(String name, String contact) {
    _name = name;
    _contact = contact;
    notifyListeners();
  }
}