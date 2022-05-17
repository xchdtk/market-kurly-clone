import 'dart:async';
import 'dart:convert';
import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class GetProducts with ChangeNotifier {
  late List<Product> _products = [];
  bool loading = false;
  List<Product> get products => _products;

  getProducts() async {
    try {
      loading = true;
      _products = await fetchProducts();
      loading = false;
      notifyListeners();
    } catch (error) {
      Exception("$error");
    }
  }
}

Future<List<Product>> fetchProducts() async {
  List<Product> productList = [];
  Future.delayed(const Duration(seconds: 5));
  try {
    final response =
        await http.get(Uri.parse("http://192.168.0.208:5000/products"));
    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body).cast<Map<String, dynamic>>();
      if (parsedBody is! List) {
        // TODO. throw exception
      }
      productList =
          parsedBody.map<Product>((item) => Product.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: "not products",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red);
    }
  } catch (error) {
    throw Exception('failed to load products');
  }
  return productList;
}
