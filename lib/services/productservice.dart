import 'dart:convert';
import 'package:d_commerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  var hclient = http.Client();

  Future<List<Product>> getAllProducts() async {
    var url = Uri.parse(
      'https://dcommercebackned.onrender.com/api/v1/product/get-product',
    );
    var response = await hclient.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return Product.fromJsonList(data['products']);
      } else {
        throw Exception('API success false: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<List<Product>> getProductsByCategory(String cname) async {
    var url = Uri.parse(
      'https://dcommercebackned.onrender.com/api/v1/product/categroies-wise-product/${cname}',
    );
    var response = await hclient.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return Product.fromJsonList(data['products']);
      } else {
        throw Exception('API success false: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
