import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/routes/router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable session persistence if the platform is web
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

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
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProxyProvider<UserProvider, VolunteeringProvider>(
          create: (_) => VolunteeringProvider(null),
          update: (_, UserProvider userProvider, VolunteeringProvider? prev) =>
              prev?.update(userProvider) ?? VolunteeringProvider(userProvider),
        ),
        ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider())
      ],
      child: MaterialApp.router(
        title: 'SER MANOS',
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
      ),
    );
  }
}
