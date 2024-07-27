import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/user_model.dart';

class SignUpTest extends StatefulWidget {
  const SignUpTest({super.key});

  @override
  _SignUpTestState createState() => _SignUpTestState();
}

class _SignUpTestState extends State<SignUpTest> {
  final ApiService apiService = ApiService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void handleSignUp() async {
    UserModel newUser = UserModel(
      id: 0,
      username: _usernameController.text ?? '',
      password: _passwordController.text ?? '',
      fullName: _fullNameController.text ?? '',
      address: _addressController.text ?? '',
      phoneNumber: _phoneNumberController.text ?? '',
      email: _emailController.text ?? '',
      roleId: 'R3', // Default role
      image: _imageController.text ?? '',
    );

    try {
      await apiService.signUp(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
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
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSignUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
