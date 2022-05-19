import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class ShoppingCartCheck with ChangeNotifier {
  List _shoppingCart = [];

  List get shoppingCart => _shoppingCart;

  Future<void> addProductToCart(product, quantity) async {
    final box = Hive.box("cart");

    if (box.containsKey(product.productId)) {
      final productPresentQuantity = box.get(product.productId).quantity;
      await box.put(product.productId,
          {product: product, quantity: productPresentQuantity + quantity});
    }
    await box.put(product.productId, {product: product, quantity: quantity});

    notifyListeners();
  }
}
