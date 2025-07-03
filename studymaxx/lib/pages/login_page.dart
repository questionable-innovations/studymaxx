import '../auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text, 
        _passwordController.text,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: login,
            child: Text('Login'),
          ),
          GestureDetector(
            child: Text("Don't have and accout already? Sign up"),
            onTap: () => {Navigator.pushNamed(context, "/signup")},
          ),
          ],
        ),
      )
    );
  }
}
