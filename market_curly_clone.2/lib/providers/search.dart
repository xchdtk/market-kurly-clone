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
    _listWidget = data;
    notifyListeners();
  }
}

class RecentSearchesCheck with ChangeNotifier {
  List _searchWords = [];

  List get searchWords => _searchWords;

  Future<void> addSearchWords(title) async {
    final box = Hive.box('list');
    if (!box.values.toList().contains(title)) {
      await box.add(title);
    }

    _searchWords = [
      for (var key in box.keys.toList()) [key, box.get(key)]
    ];

    notifyListeners();
  }

  Future<void> updateSearchWords(value) async {
    final box = Hive.box('list');
    await box.delete(value);

    if (box.values.toList().isEmpty) {
      _searchWords = [];
    } else {
      _searchWords = [
        for (var key in box.keys.toList()) [key, box.get(key)]
      ];
    }

    notifyListeners();
  }

  Future<void> deleteSearchWords() async {
    final box = Hive.box('list');
    await box.clear();
    _searchWords = [];
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
