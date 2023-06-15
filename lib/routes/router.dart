import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/error.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/volunteering.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class SerManosRouter {
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
          return HomePage(tab: 0);
        },
        routes: [
          GoRoute(
            name: SerManosPagesName.volunteeringDetail,
            path: ':id',
            builder: (context, state) {
              // TODO: check if extra is null in order to fetch data
              VolunteeringModel volunteering = state.extra as VolunteeringModel;
              return VolunteeringPage(
                volunteering: volunteering,
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
      ),
      GoRoute(
        name: SerManosPagesName.news,
        path: "/news",
        builder: (context, state) => HomePage(tab: 2),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
