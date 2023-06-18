import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/pages/edit_profile.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/error.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/news_details.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/volunteering_details.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';

class SerManosRouter {
  static final List<String> unauthorizedRoutes = [
    '/onboarding',
    '/onboarding/signup',
    '/onboarding/signin',
  ];

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/onboarding',
      ),
      GoRoute(
        name: SerManosPagesName.onboarding,
        path: "/onboarding",
        builder: (context, state) => const EntryPage(),
      ),
      GoRoute(
        name: SerManosPagesName.signup,
        path: "/onboarding/signup",
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        name: SerManosPagesName.signin,
        path: "/onboarding/signin",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: SerManosPagesName.welcome,
        path: "/welcome",
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: SerManosPagesName.volunteering,
        path: "/volunteering",
        builder: (context, state) {
          final volunteeringProvider =
              Provider.of<VolunteeringProvider>(context);

          if (volunteeringProvider.volunteerings == null && state.location != "/volunteering") {
            volunteeringProvider.fetchVolunteerings();
          }

          return HomePage(
            tab: 0,
          );
        },
        routes: [
          GoRoute(
            name: SerManosPagesName.volunteeringDetails,
            path: ':id',
            builder: (context, state) {
              print("HELLO FROM /volunteering/:id");
              return VolunteeringDetailsPage(
                id: state.pathParameters['id']!,
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: SerManosPagesName.profile,
        path: "/profile",
        builder: (context, state) {
          return HomePage(tab: 1);
        },
        routes: [
          GoRoute(
            name: SerManosPagesName.profileEdit,
            path: 'edit',
            builder: (context, state) {
              return const EditProfilePage();
            },
          ),
        ],
      ),
      GoRoute(
        name: SerManosPagesName.news,
        path: "/news",
        builder: (context, state) => HomePage(tab: 2),
        routes: [
          GoRoute(
            name: SerManosPagesName.newsDetails,
            path: ':id',
            builder: (context, state) {
              return NewsDetailsPage(
                id: state.pathParameters['id']!,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) async {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      if (userProvider.user == null) {
        await userProvider.loadUserFromCache();
      }

      final bool isUnauthorizedRoute =
          unauthorizedRoutes.any((element) => element == state.location);
      final bool isLoggedIn = userProvider.user != null;

      if (isUnauthorizedRoute && isLoggedIn) {
        return '/volunteering';
      } else if (isLoggedIn) {
        return null;
      }
      
      return isUnauthorizedRoute ? null : '/onboarding';
    },
  );
}
