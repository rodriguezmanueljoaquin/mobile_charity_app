import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/routes/router.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kIsWeb;

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // If the system can show an authorization request dialog
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    // Request system's tracking authorization dialog
    await AppTrackingTransparency.requestTrackingAuthorization();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.denied) {
    // The user has denied access to the system's tracking authorization dialog
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    FirebaseAnalytics.instance.setConsent(
        adStorageConsentGranted: false, analyticsStorageConsentGranted: false);
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
