import 'package:flutter/material.dart';

import 'package:second_task/featurs/auth/screens/login_page.dart';
import 'package:second_task/featurs/auth/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  if (Firebase.apps.isEmpty) {
    print("a");
    WidgetsFlutterBinding.ensureInitialized();
    print(" bending initializedd");
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print(" fireBase success");
    } catch (e) {
      print(e);
    }
    print("a");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {"l": (context) => LoginPage(), "r": (context) => RegisterPage()},
    );
  }
}
