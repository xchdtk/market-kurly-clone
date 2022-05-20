import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:market_curly_clone/models/login.dart';

class LoginState with ChangeNotifier {
  bool _isLogined = false;

  bool get isLogined => _isLogined;

  void changeLoginState() {
    _isLogined = !_isLogined;
    notifyListeners();
  }
}

Future<String> postLogin(String userId, String password) async {
  try {
    Map<String, String> data = {"userId": userId, "password": password};
    final body = jsonEncode(data);
    final response = await http.post(
        Uri.parse("http://192.168.0.208:5000/login"),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);
      final loginData = Login.fromJson(parsedBody);
      
      await Hive.box('LocalMarketKulry').put('userId', loginData.userId);
      await Hive.box('LocalMarketKulry')
          .put('accessToken', loginData.accessToken);

      return 'success login';
    } else {
      return 'fail login';
    }
  } catch (error) {
    throw Exception(error);
  }
}
