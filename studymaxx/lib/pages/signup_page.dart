import '../auth/auth_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await authService.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    void signUpAndAutoLogin() {
      signUp();
      Navigator.pushNamed(context, "/");
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          // Email
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          // Password
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          // Login button
          ElevatedButton(
            onPressed: signUpAndAutoLogin,
            child: Text('Sign up'),
          ),
          ],
        ),
      )
    );
  }
}
