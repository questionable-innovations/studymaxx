import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange, 
      builder: (context, snapshot) {
        // Loading 
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        // Check session is valid
        final session = snapshot.hasData ? snapshot.data!.session : null;
        return session == null ? LoginPage() : HomePage();
      }
      );
    }  
}
