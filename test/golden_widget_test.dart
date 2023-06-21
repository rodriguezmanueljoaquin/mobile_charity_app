import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
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
import 'package:mobile_charity_app/routes/home_tabs.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_provider.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

// TO RENOVATE GOLDEN: flutter test --update-goldens

Future<void> goldenTest(WidgetTester tester, Widget widget, String name) async {
  await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MaterialApp(
      home: ChangeNotifierProvider<UserProvider>.value(
          value: MockUserProvider(), child: MaterialApp(home: widget)))));
  await multiScreenGolden(tester, name);
}

void main() {
  loadAppFonts();

  testGoldens('Golden test entry page', (WidgetTester tester) async {
    await goldenTest(tester, const EntryPage(), 'entry_page');
  });

  testGoldens('Golden test error page', (WidgetTester tester) async {
    await goldenTest(tester, const ErrorPage(), 'error_page');
  });

  testGoldens('Golden test login page', (WidgetTester tester) async {
    await goldenTest(tester, const LoginPage(), 'login_page');
  });

  testGoldens('Golden test register page', (WidgetTester tester) async {
    await goldenTest(tester, const RegisterPage(), 'register_page');
  });

  testGoldens('Golden test welcome page', (WidgetTester tester) async {
    await goldenTest(tester, const WelcomePage(), 'welcome_page');
  });

  testGoldens('Golden test edit profile page', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MaterialApp(
        home: ChangeNotifierProvider<UserProvider>.value(
            value: MockUserProvider(),
            child: const MaterialApp(home: EditProfilePage())))));
    await multiScreenGolden(tester, 'edit_profile_page');
  });

  testGoldens('Golden test home page profile tab', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MaterialApp(
        home: ChangeNotifierProvider<UserProvider>.value(
            value: MockUserProvider(),
            child: HomePage(
              activeTabIndex: HomeTabs.profile.index,
            )))));
    await multiScreenGolden(tester, 'home_page_profile_tab');
  });

  testGoldens('Golden test home page news tab', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MaterialApp(
        home: ChangeNotifierProvider<NewsProvider>.value(
            value: MockNewsProvider(),
            child: HomePage(
              activeTabIndex: HomeTabs.news.index,
            )))));

    await multiScreenGolden(tester, 'home_page_news_tab');
  });

  testGoldens('Golden test home page volunteerings tab',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>.value(
                  value: MockUserProvider()),
              ChangeNotifierProvider<VolunteeringProvider>.value(
                  value: MockVolunteeringProvider()),
            ],
            child: MaterialApp(
                home: HomePage(
              activeTabIndex: HomeTabs.volunteering.index,
            )))));

    await multiScreenGolden(tester, 'home_page_volunteerings_tab');
  });

  testGoldens('Golden test home page initial tab', (WidgetTester tester) async {
    // to check that initial default tab didnt change

    await mockNetworkImagesFor(() =>
        tester.pumpWidgetBuilder(MultiProvider(providers: [
          ChangeNotifierProvider<UserProvider>.value(value: MockUserProvider()),
          ChangeNotifierProvider<VolunteeringProvider>.value(
              value: MockVolunteeringProvider()),
        ], child: MaterialApp(home: HomePage()))));

    await multiScreenGolden(tester, 'home_page_volunteerings_tab');
  });

  testGoldens('Golden test news details page', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MaterialApp(
        home: ChangeNotifierProvider<NewsProvider>.value(
            value: MockNewsProvider(),
            child: const NewsDetailsPage(
              id: "1",
            )))));

    await multiScreenGolden(tester, 'news_details_page');
  });

  testGoldens('Golden test volunteering details page',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidgetBuilder(MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>.value(
                  value: MockUserProvider()),
              ChangeNotifierProvider<VolunteeringProvider>.value(
                  value: MockVolunteeringProvider()),
            ],
            child: const MaterialApp(
                home: VolunteeringDetailsPage(
              id: "1",
            )))));

    await multiScreenGolden(tester, 'volunteerings_detail_page');
  });
}
