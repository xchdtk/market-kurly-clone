import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/models/category.dart';

class SelectListCheck with ChangeNotifier {
  bool _isSelect = false;

  bool get isSelect => _isSelect;

  void changeSelect() {
    _isSelect = !_isSelect;
    notifyListeners();
  }
}

class GetCategories with ChangeNotifier {
  late List<Category> _categories = [];
  bool loading = false;

  List<Category> get categories => _categories;

  getCategories() async {
    try {
      loading = true;
      _categories = await fetchCategories();
      loading = false;
      notifyListeners();
    } catch (error) {
      Exception("$error");
    }
  }
}

Future<List<Category>> fetchCategories() async {
  List<Category> categoryList = [];
  Future.delayed(const Duration(seconds: 5));
  try {
    final response =
        await http.get(Uri.parse("http://192.168.0.208:5000/categories"));

    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);
      if (parsedBody is! List) {
        // ignore: todo
        // TODO. throw exception
      }

      categoryList =
          parsedBody.map<Category>((item) => Category.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: "not categories",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          backgroundColor: redColor);
    }
    return categoryList;
  } catch (error) {
    throw Exception('failed to load categories');
  }
}
