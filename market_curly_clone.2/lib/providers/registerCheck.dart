import 'package:flutter/material.dart';

class RegisterCheck with ChangeNotifier {
  // ignore: prefer_final_fields
  int _duplicateCheck = 0;

  int get duplicateCheck => _duplicateCheck;

  void changeduplicateCheck(value) {
    _duplicateCheck = value;
    notifyListeners();
  }
}
