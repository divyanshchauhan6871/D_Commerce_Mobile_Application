import 'package:d_commerce_app/allprovider/cartProvider.dart';
import 'package:d_commerce_app/allprovider/orderProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              elevation: 10,
              color: const Color.fromARGB(255, 4, 61, 77),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cartProvider.clearCart();
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Clear ",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Icon(
                          Icons.shopping_cart,
                          size: 22,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
                cartProvider.cart.isEmpty
                    ? const Center(child: Text("Your cart is empty"))
                    : ListView.builder(
                      itemCount: cartProvider.cart.length,
                      itemBuilder: (context, index) {
                        final entry = cartProvider.cart.entries.toList()[index];
                        final product = entry.key;
                        final quantity = entry.value;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      'https://dcommercebackned.onrender.com/api/v1/product/product-photo/${product.id}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                                size: 100,
                                              ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartProvider.decreaseQuantity(
                                              product,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          onPressed: () {
                                            cartProvider.increaseQuantity(
                                              product,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "₹${product.price}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "71% Off",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      const Text("2 Offers Applied"),
                                      const SizedBox(height: 6),
                                      const Text("Delivery by Jun 21"),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              cartProvider.removeProduct(
                                                product,
                                              );
                                            },
                                            child: const Text("Remove"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
          Container(
            color: const Color.fromARGB(255, 0, 40, 58),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Amount",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "₹${cartProvider.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cartProvider.cart.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cart is empty. Add items first."),
                        ),
                      );
                      return;
                    }
                    if (userProvider.authenticated == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("please login first.")),
                      );
                      Navigator.pushNamed(context, '/login');
                    }
                    orderProvider.addOrder(cartProvider.cart);
                    cartProvider.clearCart();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order placed successfully!"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        color: const Color.fromARGB(255, 0, 40, 58),
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
