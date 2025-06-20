import 'package:flutter/material.dart';
import 'package:d_commerce_app/model/product.dart';
import 'package:d_commerce_app/services/productservice.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  String _error = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    try {
      _products = await ProductService().getAllProducts();
      _error = '';
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
