import 'package:flutter/material.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SER MANOS',
      // home: LoginPage(),
      home: HomePage(),
      // home: RegisterPage(),
      // home: EntryPage(),
      // home: WelcomePage(),
    );
  }
}
