import 'package:flutter/material.dart';
import 'package:d_commerce_app/model/product.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _cart = {};

  Map<Product, int> get cart => _cart;

  void addProduct(Product p) {
    if (_cart.containsKey(p)) {
      _cart[p] = _cart[p]! + 1;
    } else {
      _cart[p] = 1;
    }
    notifyListeners();
  }

  void removeProduct(Product p) {
    _cart.remove(p);
    notifyListeners();
  }

  void increaseQuantity(Product p) {
    if (_cart.containsKey(p)) {
      _cart[p] = _cart[p]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product p) {
    if (_cart.containsKey(p)) {
      if (_cart[p]! > 1) {
        _cart[p] = _cart[p]! - 1;
      } else {
        _cart.remove(p);
      }
      notifyListeners();
    }
  }

  int getQuantity(Product p) {
    return _cart[p] ?? 0;
  }

  double get totalAmount {
    double total = 0;
    _cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
