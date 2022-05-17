import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchTextCheck with ChangeNotifier {
  String _searchWord = '';
  late Widget _listWidget;

  String get searchWord => _searchWord;
  Widget get listWidget => _listWidget;

  void changeText(text) {
    _searchWord = text;
    notifyListeners();
  }

  void changeWidget(data) {
    _listWidget = data;
    notifyListeners();
  }
}

class RecentSearchesCheck with ChangeNotifier {
  List _searchWords = [];

  List get searchWords => _searchWords;

  void getItem() {
    final box = Hive.box('list');

    List defaltList = box.values.toList();
    _searchWords = defaltList.reversed.toList();
    notifyListeners();
  }

  void addSearchWords(value) {
    final box = Hive.box('list');
    box.add(value);

    notifyListeners();
  }
}
