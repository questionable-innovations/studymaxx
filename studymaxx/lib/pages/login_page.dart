import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

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
            FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ElevatedButton(
                  onPressed: login,
                  child: Text('Login'),
                ),
              )
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                  Text("Don't have and accout already?"),
                  Text(
                    " Sign up",
                    style: TextStyle(color: Colors.deepPurple),
                  ), 
                ],
              ),
              onTap: () => Navigator.pushNamed(context, "/signup"),
            ),
          ],
        ),
      )
    );
  }
}
