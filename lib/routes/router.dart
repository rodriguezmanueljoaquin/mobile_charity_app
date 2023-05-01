import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/error.dart';
import 'package:mobile_charity_app/pages/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/volunteering.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class SerManosRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/volunteering',
      ),
      GoRoute(
        name: SerManosPagesName.onboarding,
        path: "/onboarding",
        pageBuilder: (context, state) => const MaterialPage(child: EntryPage()),
        routes: [
          GoRoute(
            name: SerManosPagesName.signin,
            path: "signin",
            pageBuilder: (context, state) =>
                const MaterialPage(child: LoginPage()),
          ),
          GoRoute(
            name: SerManosPagesName.signup,
            path: "signup",
            pageBuilder: (context, state) =>
                const MaterialPage(child: RegisterPage()),
          ),
        ],
      ),
      GoRoute(
          name: SerManosPagesName.welcome,
          path: "/welcome",
          pageBuilder: (context, state) =>
              const MaterialPage(child: WelcomePage())),
      GoRoute(
        name: SerManosPagesName.volunteering,
        path: "/volunteering",
        pageBuilder: (context, state) => MaterialPage(child: HomePage(tab: 0)),
        routes: [
          GoRoute(
            name: SerManosPagesName.volunteeringDetail,
            path: ':id',
            pageBuilder: (context, state) {
              VolunteeringModel volunteering = state.extra as VolunteeringModel;
              return MaterialPage(
                  child: VolunteeringPage(
                volunteering: volunteering,
                id: state.pathParameters['id']!,
              ));
            },
          ),
        ],
      ),
      GoRoute(
        name: SerManosPagesName.profile,
        path: "/profile",
        pageBuilder: (context, state) => MaterialPage(child: HomePage(tab: 1)),
      ),
      GoRoute(
        name: SerManosPagesName.news,
        path: "/news",
        pageBuilder: (context, state) => MaterialPage(child: HomePage(tab: 2)),
      ),
    ],
    errorPageBuilder: (context, state) =>
        const MaterialPage(child: ErrorPage()),
  );
}
