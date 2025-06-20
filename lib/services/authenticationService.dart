import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:d_commerce_app/allprovider/userProvider.dart';

class AuthenticationService {
  var hclient = http.Client();

  Future<bool?> loginController(
    BuildContext context,
    String email,
    String password,
  ) async {
    var url = Uri.parse(
      'https://dcommercebackned.onrender.com/api/v1/auth/login',
    );

    var response = await hclient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success'] == true) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(data['user'], data['token']);
        return true;
      }
    }
    return false;
  }

  Future<bool?> registerController(
    BuildContext context,
    String name,
    String email,
    String password,
    String address,
    String phone,
    String answer,
  ) async {
    var url = Uri.parse(
      'https://dcommercebackned.onrender.com/api/v1/auth/register',
    );

    var response = await hclient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phone": phone,
        "answer": answer,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success'] == true) {
        return true;
      }
    }

    return false;
  }
}
