import 'package:d_commerce_app/services/authenticationService.dart';
import 'package:d_commerce_app/style.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  sugnUpController() async {
    bool? registered = await AuthenticationService().registerController(
      context,
      nameController.text,
      emailController.text,
      passwordController.text,
      addressController.text,
      numberController.text,
      nicknameController.text,
    );

    if (registered!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You have succesfully registered")),
      );
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Some Error occurred please try again")),
      );
      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      addressController.text = "";
      numberController.text = "";
      nicknameController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.person_2_rounded,
                size: 80,
                color: Colors.lightBlue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: nicknameController,
                        decoration: InputDecoration(
                          labelText: "Nickname",
                          prefixIcon: Icon(Icons.face),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: numberController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            sugnUpController();
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
                            "Sign up",
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 245, 245, 245),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text("Already a user"),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                overlayColor: const Color.fromARGB(255, 70, 122, 253),
                backgroundColor: const Color.fromARGB(255, 0, 25, 65),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                "Log in",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
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
