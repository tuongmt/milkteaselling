import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/category_model.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/models/topping_model.dart';
import 'package:flutter_coffee_app/models/user_model.dart';

void main() {
  runApp(MaterialApp(
    home: LoginTest(),
  ));
}

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  final ApiService apiService = ApiService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void handleLogin() async {
    try {
      // await apiService.logIn(
      //     _usernameController.text, _passwordController.text);
      var result =  await apiService.updateTopping(ToppingModel(id: 4, categoryId: 2, toppingName: "My topping 6", price: "9281", image: ""));
      //var result = await apiService.getOrders("1");
      // print(result);
      print("hello");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
