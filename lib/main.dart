import 'package:d_commerce_app/allprovider/cartProvider.dart';
import 'package:d_commerce_app/allprovider/categoryProvider.dart';
import 'package:d_commerce_app/allprovider/orderProvider.dart';
import 'package:d_commerce_app/allprovider/productProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/screens/Cart.dart';
import 'package:d_commerce_app/screens/categoriesScreen.dart';
import 'package:d_commerce_app/screens/homescreen.dart';
import 'package:d_commerce_app/screens/loginscreen.dart';
import 'package:d_commerce_app/screens/productScreen.dart';
import 'package:d_commerce_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: DCommerce(),
    ),
  );
}

class DCommerce extends StatelessWidget {
  DCommerce({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "D-Commerce",
      initialRoute: '/',
      routes: {
        '/': (context) => Homescreen(),
        '/signup': (context) => Registerpage(),
        '/login': (context) => Loginscreen(),
        '/products': (context) => ProductScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/cart': (context) => Cart(),
      },
    );
  }
}
