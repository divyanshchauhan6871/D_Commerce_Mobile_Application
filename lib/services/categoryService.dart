import 'dart:convert';
import 'package:d_commerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  var hclient = http.Client();

  Future<List<Category>> getAllCategory() async {
    var url = Uri.parse(
      'https://dcommercebackned.onrender.com/api/v1/category/get-category',
    );
    var response = await hclient.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return Category.fromJsonList(data['category']);
      } else {
        throw Exception('API success false: ${data['category']}');
      }
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
