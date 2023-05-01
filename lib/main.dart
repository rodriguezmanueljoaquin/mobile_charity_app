import 'package:flutter/material.dart';
import 'package:mobile_charity_app/routes/router.dart';

void main() {
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
    return MaterialApp.router(
      routerDelegate: SerManosRouter().router.routerDelegate,
      routeInformationParser: SerManosRouter().router.routeInformationParser,
    );
  }
}
