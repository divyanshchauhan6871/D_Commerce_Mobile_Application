import 'package:d_commerce_app/services/categoryService.dart';
import 'package:flutter/cupertino.dart';
import 'package:d_commerce_app/model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    try {
      _categories = await CategoryService().getAllCategory();
    } catch (e) {
      print("Error fetching categories: $e");
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
