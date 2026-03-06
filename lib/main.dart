import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:second_task/featurs/details_page/screens/details_page.dart';
import 'package:second_task/featurs/feature_home_page/screens/home_page.dart';
import 'package:second_task/featurs/feature_login_screen/screens/login_page.dart';
import 'package:second_task/featurs/feature_register/screens/register_page.dart';
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
      home: FirebaseAuth.instance.currentUser?.uid == null
          ? LoginPage()
          : HomePage(),
      routes: {
        "l": (context) => LoginPage(),
        "r": (context) => RegisterPage(),
        "h": (context) => HomePage(),
        "d": (context) => DetailsPage(),
      }, 
    );
  }
}
