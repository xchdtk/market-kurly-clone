import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_curly_clone/screen/search/search_screen.dart';

class SearchTextCheck with ChangeNotifier {
  String _searchWord = '';
  List<Widget> _listWidget = [const ProductTitleWidget()];

  String get searchWord => _searchWord;
  List<Widget> get listWidget => _listWidget;

  void changeText(text) {
    _searchWord = text;
    notifyListeners();
  }

  void changeWidget(data) {
    print(data);
    _listWidget = data;
    notifyListeners();
  }
}

class RecentSearchesCheck with ChangeNotifier {
  List _searchWords = [];

  List get searchWords => _searchWords;

  void getItem() {
    final box = Hive.box('list');
    if (box.values.toList().isEmpty) {
      _searchWords = [];
    } else {
      _searchWords = box.values.toList();
    }
    notifyListeners();
  }

  void addSearchWords(title) {
    final box = Hive.box('list');
    if (!box.values.toList().contains(title)) {
      box.add(title);
    }

    notifyListeners();
  }

  void updateSearchWords(value) {
    final box = Hive.box('list');
    box.delete(value);
    notifyListeners();
  }

  void deleteSearchWords() {
    final box = Hive.box('list');
    box.clear();
    notifyListeners();
  }
}

class RecentSearchesState with ChangeNotifier {
  bool _deleteState = false;

  bool get deleteState => _deleteState;

  void changeState() {
    _deleteState = !_deleteState;
    notifyListeners();
  }
}
