// ignore_for_file: prefer_is_empty

import 'package:d_commerce_app/allprovider/categoryProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/screens/Categorywiseproduct.dart';
import 'package:d_commerce_app/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("D-Commerce", style: Divyansh().appbarhead),
        backgroundColor: const Color.fromARGB(255, 0, 40, 58),
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body:
          categoryProvider.categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: categoryProvider.categories.length,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                itemBuilder:
                    (context, index) => Card(
                      color: const Color.fromARGB(255, 0, 225, 255),
                      shadowColor: const Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          categoryProvider.categories[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.category,
                          color: Colors.black,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          print(categoryProvider.categories[index].slug);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => CategoriesWiseProduct(
                                    name:
                                        categoryProvider.categories[index].slug,
                                  ),
                            ),
                          );
                        },
                      ),
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
