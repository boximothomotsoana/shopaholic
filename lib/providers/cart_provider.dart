import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  //List<Map<String, dynamic>> get cartItems => _cartItems;

  List<Map<String, dynamic>> cartItems = [
    {
      "title": "Wireless Headphones",
      "image": "assets/images/rr.png",
      "price": 49.99,
      "salePrice": 39.99,
      "isOnSale": true,
      "quantity": 1,
    },
    {
      "title": "Smart Watch",
      "image": "assets/images/rr.png",
      "price": 99.99,
      "salePrice": null,
      "isOnSale": false,
      "quantity": 2,
    },
    {
      "title": "Gaming Mouse",
      "image": "assets/images/rr.png",
      "price": 29.99,
      "salePrice": 24.99,
      "isOnSale": true,
      "quantity": 1,
    },
  ];

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      double itemPrice = item["salePrice"] ?? item["price"];
      total += itemPrice * item["quantity"];
    }
    return total;
  }

  void addItem(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void updateQuantity(int index, int change) {
    _cartItems[index]["quantity"] += change;
    if (_cartItems[index]["quantity"] == 0) {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
}
