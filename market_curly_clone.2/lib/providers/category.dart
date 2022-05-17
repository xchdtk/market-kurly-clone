import 'package:flutter/material.dart';

class SelectListCheck with ChangeNotifier {
  bool _isSelect = false;

  bool get isSelect => _isSelect;

  void changeSelect() {
    _isSelect = !_isSelect;
    notifyListeners();
  }
}
