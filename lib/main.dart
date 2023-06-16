import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/routes/router.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = SerManosRouter().router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserProvider>(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp.router(
        title: 'SER MANOS',
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
      ),
    );
  }
}
