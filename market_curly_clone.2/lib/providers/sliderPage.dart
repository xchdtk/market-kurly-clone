import 'package:flutter/material.dart';

// ignore: camel_case_types
class sliderPage with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void changeCurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
