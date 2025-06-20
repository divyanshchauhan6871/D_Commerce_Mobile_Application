import 'package:d_commerce_app/allprovider/categoryProvider.dart';
import 'package:d_commerce_app/allprovider/productProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/screens/Categorywiseproduct.dart';
import 'package:d_commerce_app/screens/SingleProductScreen.dart';
import 'package:d_commerce_app/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  Widget _featureChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.teal.shade700),
      label: Text(label),
      backgroundColor: Colors.teal.shade100,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("D-Commerce", style: Divyansh().appbarhead),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 40, 58),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Icon(Icons.person, size: 35, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to D-Commerce!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Explore variety of products and categories at your fingertips. "
                    "Fast delivery, amazing deals, and a seamless shopping experience just for you!",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _featureChip(Icons.local_offer, "Best Prices"),
                      _featureChip(Icons.category, "Wide Categories"),
                      _featureChip(Icons.delivery_dining, "Fast Delivery"),
                      _featureChip(Icons.support_agent, "24x7 Support"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/categories');
                  },
                  child: Text("Explore"),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 120,
              child:
                  categoryProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          final category = categoryProvider.categories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => CategoriesWiseProduct(
                                        name: category.slug,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 6),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/products');
                  },
                  child: Text("Explore"),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 220,
              child:
                  productProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          SingleProductScreen(p: product),
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      'https://dcommercebackned.onrender.com/api/v1/product/product-photo/${product.id}',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) =>
                                              Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "₹${product.price}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "Enjoy Shopping",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
              label: Text("Products", style: Divyansh.bottomnav),
            ),

            userProvider.authenticated
                ? ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.shade400,
                  ),
                  icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
                  label: Text("Products", style: Divyansh.bottomnav),
                )
                : Text(""),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/categories');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.shade400,
              ),
              icon: Icon(Icons.category_outlined, color: Colors.black),
              label: Text("Categories", style: Divyansh.bottomnav),
            ),
          ],
        ),
      ),
    );
  }
}
