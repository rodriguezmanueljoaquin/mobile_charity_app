import 'package:flutter/material.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SER MANOS',
      home: LoginPage(),
      // home: HomePage(),
      // home: RegisterPage(),
      // home: EntryPage(),
      // home: WelcomePage(),
      // home: HomePage(),
    );
  }
}
