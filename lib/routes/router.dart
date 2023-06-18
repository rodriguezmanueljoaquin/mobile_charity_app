import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/pages/edit_profile.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/error.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/news_details.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/volunteering_details.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';
import 'package:mobile_charity_app/utils/logger.dart';

class SerManosRouter {
  static final List<String> authlessRoutes = [
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

          if (volunteeringProvider.volunteerings == null &&
              state.location != "/volunteering") {
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
              String id = state.pathParameters['id']!;

              FirebaseAnalytics.instance.logEvent(
                name: 'select_content',
                parameters: {
                  'content_type': 'volunteering',
                  'id': id,
                },
              );

              logger.d("HELLO FROM /volunteering/:id");
              return VolunteeringDetailsPage(
                id: id,
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
        builder: (context, state) {
          final newsProvider = Provider.of<NewsProvider>(context);

          if (newsProvider.news == null && state.location != "/news") {
            newsProvider.fetchNews();
          }

          return HomePage(
            tab: 0,
          );
        },
        routes: [
          GoRoute(
            name: SerManosPagesName.newsDetails,
            path: ':id',
            builder: (context, state) {
              String id = state.pathParameters['id']!;

              FirebaseAnalytics.instance.logEvent(
                name: 'select_content',
                parameters: {
                  'content_type': 'news',
                  'id': id,
                },
              );

              return NewsDetailsPage(
                id: id,
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

      final bool isAuthlessRoute =
          authlessRoutes.any((element) => element == state.location);
      final bool isLoggedIn = userProvider.user != null;

      if (isAuthlessRoute && isLoggedIn) {
        return '/volunteering';
      } else if (isLoggedIn) {
        return null;
      }

      // log unauthorized access attempts
      if (!isAuthlessRoute) {
        logger.w('Unauthorized access attempt to ${state.location}');
        FirebaseAnalytics.instance.logEvent(
          name: 'unauthorized_access',
          parameters: {
            'screen_name': state.location,
          },
        );
      }

      return isAuthlessRoute ? null : '/onboarding';
    },
  );
}
