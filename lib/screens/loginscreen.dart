import 'package:d_commerce_app/allprovider/orderProvider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';
import 'package:d_commerce_app/services/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:d_commerce_app/style.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginController() async {
    bool? authenticated = await AuthenticationService().loginController(
      context,
      emailController.text,
      passwordController.text,
    );

    if (authenticated!) {
      Navigator.pushNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Please check credentials.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
          TextButton(
            onPressed: () {
              userProvider.clearUser();
              Navigator.pushNamed(context, '/');
            },
            child:
                userProvider.authenticated == true
                    ? Icon(Icons.logout, color: Colors.white, size: 25)
                    : Text(""),
          ),
        ],
      ),
      body:
          userProvider.authenticated == true
              ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      elevation: 15,
                      color: const Color.fromARGB(255, 8, 26, 41),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "Your Orders",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.shopping_bag_rounded,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orderProvider.orders.length > 0
                      ? Expanded(
                        child: ListView.builder(
                          itemCount: orderProvider.orders.length,
                          itemBuilder: (context, i) {
                            final order = orderProvider.orders[i];

                            return Card(
                              elevation: 6,
                              margin: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order #${i + 1}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(),
                                    ...order.entries.map((entry) {
                                      final product = entry.key;
                                      final quantity = entry.value;

                                      return ListTile(
                                        leading: Image.network(
                                          'https://dcommercebackned.onrender.com/api/v1/product/product-photo/${product.id}',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (_, __, ___) => const Icon(
                                                Icons.broken_image,
                                              ),
                                        ),
                                        title: Text(product.name),
                                        subtitle: Text("Qty: $quantity"),
                                        trailing: Text(
                                          "₹${(product.price * quantity).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      : Center(child: Text("No yet orders")),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person_pin,
                                    size: 80,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Welcome, ${userProvider.user['name']}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.deepPurple),
                                SizedBox(width: 10),
                                Text(
                                  "${userProvider.user['email']}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone_android, color: Colors.green),
                                SizedBox(width: 10),
                                Text(
                                  "${userProvider.user['phone']}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "${userProvider.user['address']}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  userProvider.clearUser();
                                  Navigator.pushNamed(context, '/');
                                },
                                icon: Icon(Icons.logout),
                                label: Text("Logout"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 40,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lock_person_rounded,
                          size: 80,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(height: 20),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: 28,
                                      color: Colors.red,
                                    ),
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: 28,
                                      color: const Color.fromARGB(
                                        255,
                                        202,
                                        13,
                                        0,
                                      ),
                                    ),
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    loginController();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      0,
                                      50,
                                      125,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                        255,
                                        245,
                                        245,
                                        245,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "New to the platform?",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            overlayColor: const Color.fromARGB(
                              255,
                              70,
                              122,
                              253,
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              0,
                              25,
                              65,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 2, 48, 85),
              const Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
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
