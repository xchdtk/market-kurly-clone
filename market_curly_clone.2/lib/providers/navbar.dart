import 'package:flutter/material.dart';

class NavbarIndex with ChangeNotifier {
  int _seletedIndex = 0;

  int get seletedIndex => _seletedIndex;

  // ignore: non_constant_identifier_names
  void ChangeSeletedIndex(index) {
    _seletedIndex = index;
    notifyListeners();
  }
}
