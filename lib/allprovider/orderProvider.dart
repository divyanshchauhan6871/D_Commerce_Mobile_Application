import 'package:flutter/material.dart';
import 'package:d_commerce_app/model/product.dart';

class OrderProvider with ChangeNotifier {
  final List<Map<Product, int>> _orders = [];
  List<Map<Product, int>> get orders => _orders;

  void addOrder(Map<Product, int> cartSnapshot) {
    final orderCopy = Map<Product, int>.from(cartSnapshot);
    _orders.add(orderCopy);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
