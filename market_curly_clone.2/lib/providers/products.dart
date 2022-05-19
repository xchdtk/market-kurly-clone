import 'dart:async';
import 'dart:convert';
import 'package:market_curly_clone/colors/color.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class GetProducts with ChangeNotifier {
  List<Product> _products = [];
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

class GetProduct with ChangeNotifier {
  late Product _product;
  bool loading = false;
  Product get product => _product;

  Future<void> getProduct(productId) async {
    try {
      loading = true;
      _product = await fetchProduct(productId);
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
        // ignore: todo
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
          backgroundColor: redColor);
    }
  } catch (error) {
    throw Exception('failed to load products');
  }
  return productList;
}

Future<Product> fetchProduct(productId) async {
  late Product product;
  try {
    final response = await http
        .get(Uri.parse("http://192.168.0.208:5000/products/$productId"));
    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);
      product = Product.fromJson(parsedBody);
    } else {
      Fluttertoast.showToast(
          msg: "not product",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          backgroundColor: redColor);
    }
  } catch (error) {
    Exception('failed to load product');
  }
  return product;
}
