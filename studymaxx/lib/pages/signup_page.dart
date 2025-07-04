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
  final _confirmPasswordController = TextEditingController();

  Future<bool> signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    SnackBar unequalPasswordBar = const SnackBar(
      content: Text("Error! password is not the same as confirmPassword")
    );

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(unequalPasswordBar);
      return false;
    }

    try {
      await authService.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
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
            // Confirm password
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            // Signin button
            FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ElevatedButton(
                  onPressed: signUp,
                  child: Text('Sign up'),
                  ),
                )
            ),
            // Return to login page
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                  Text("Already have an account?"),
                  Text(
                    " Log in",
                    style: TextStyle(color: Colors.deepPurple),
                  ), 
                ],
              ),
              onTap: () => Navigator.pushNamed(context, "/"),
            ),
          ],
        ),
      )
    );
  }
}
