import 'package:d_commerce_app/allprovider/cartProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/model/product.dart';
import 'package:d_commerce_app/screens/SingleProductScreen.dart';
import 'package:d_commerce_app/services/categoryService.dart';
import 'package:d_commerce_app/services/productservice.dart';
import 'package:d_commerce_app/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesWiseProduct extends StatefulWidget {
  final name;
  const CategoriesWiseProduct({super.key, required this.name});

  @override
  State<CategoriesWiseProduct> createState() => _CategoriesWiseProductState();
}

class _CategoriesWiseProductState extends State<CategoriesWiseProduct> {
  List<Product> categoryProducts = [];
  bool isLoading = true;
  void initState() {
    super.initState();
    getALLProducts();
  }

  getALLProducts() async {
    categoryProducts = await ProductService().getProductsByCategory(
      widget.name,
    );
    if (categoryProducts.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("D-Commerce", style: Divyansh().appbarhead),
        backgroundColor: Color.fromARGB(255, 0, 40, 58),
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:
          categoryProducts.isEmpty
              ? const Center(child: Text("Loading please wait"))
              : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              color: Colors.grey[300],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                'https://dcommercebackned.onrender.com/api/v1/product/product-photo/${product.id}',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "₹${product.price}",
                                style: const TextStyle(color: Colors.green),
                              ),
                              SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                SingleProductScreen(p: product),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "See more",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartProvider.addProduct(product);
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            content: Text(
                                              "${product.name} is added to the cart",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.add_shopping_cart,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        color: Color.fromARGB(255, 0, 40, 58),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/products');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.shade400,
              ),
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
              label: Text("Products", style: Divyansh.bottomnav),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/categories');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.shade400,
              ),
              icon: const Icon(Icons.category_outlined, color: Colors.black),
              label: Text("Categories", style: Divyansh.bottomnav),
            ),
          ],
        ),
      ),
    );
  }
}
