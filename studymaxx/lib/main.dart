import 'auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:studymaxx/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Initialise supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xzsyhlglrnixjuggldcb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6c3lobGdscm5peGp1Z2dsZGNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA5MDI0MDIsImV4cCI6MjA2NjQ3ODQwMn0.yYYtkQ9eAZZekw8yPIB6J38rpJ_PXSIBr7mM1v57Vh4',
    );
  // Run app
  runApp(MaterialApp(
    routes: <String, WidgetBuilder> {
      "/" : (BuildContext context) => AuthGate(),
      "/signup" : (BuildContext context) => SignupPage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return const MaterialApp(
          title: 'Instruments',
          home: HomePage(),
          );
    }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client
    .from('instruments')
    .select();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Center(
            child: Column(
              children: [
              Text("hi"),
              Text("Hello"),
              ]
              )
            ),
          );
    }
}
