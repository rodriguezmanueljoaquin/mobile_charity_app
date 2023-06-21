import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_provider.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

// TO RENOVATE GOLDEN: flutter test --update-goldens

Future<void> goldenTest(WidgetTester tester, Widget widget, String name,
    List<ChangeNotifierProvider> providers) async {
  DeviceBuilder deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [
      Device.phone,
      Device.iphone11,
      Device.tabletPortrait,
      Device.tabletLandscape,
    ])
    ..addScenario(
        widget: MultiProvider(
      providers: providers,
      child: MaterialApp(
          home: ChangeNotifierProvider<UserProvider>.value(
              value: MockUserProvider(), child: MaterialApp(home: widget))),
    ));

  await mockNetworkImagesFor(() => tester.pumpDeviceBuilder(deviceBuilder));
  await screenMatchesGolden(tester, name);
}

void main() {
  loadAppFonts();
  ChangeNotifierProvider<UserProvider> userMockedProvider =
      ChangeNotifierProvider<UserProvider>.value(value: MockUserProvider());
  ChangeNotifierProvider<NewsProvider> newsMockedProvider =
      ChangeNotifierProvider<NewsProvider>.value(value: MockNewsProvider());
  ChangeNotifierProvider<VolunteeringProvider> volunteeringMockedProvider =
      ChangeNotifierProvider<VolunteeringProvider>.value(
          value: MockVolunteeringProvider());

  testGoldens('Golden test entry page', (WidgetTester tester) async {
    await goldenTest(
        tester, const EntryPage(), 'entry_page', [userMockedProvider]);
  });

  testGoldens('Golden test error page', (WidgetTester tester) async {
    await goldenTest(
        tester, const ErrorPage(), 'error_page', [userMockedProvider]);
  });

  testGoldens('Golden test login page', (WidgetTester tester) async {
    await goldenTest(
        tester, const LoginPage(), 'login_page', [userMockedProvider]);
  });

  testGoldens('Golden test register page', (WidgetTester tester) async {
    await goldenTest(
        tester, const RegisterPage(), 'register_page', [userMockedProvider]);
  });

  testGoldens('Golden test welcome page', (WidgetTester tester) async {
    await goldenTest(
        tester, const WelcomePage(), 'welcome_page', [userMockedProvider]);
  });

  testGoldens('Golden test edit profile page', (WidgetTester tester) async {
    await goldenTest(tester, const EditProfilePage(), 'edit_profile_page',
        [userMockedProvider]);
  });

  testGoldens('Golden test home page profile tab', (WidgetTester tester) async {
    await goldenTest(tester, HomePage(activeTabIndex: HomeTabs.profile.index),
        'home_page_profile_tab', [userMockedProvider]);
  });

  testGoldens('Golden test home page news tab', (WidgetTester tester) async {
    await goldenTest(tester, HomePage(activeTabIndex: HomeTabs.news.index),
        'home_page_news_tab', [newsMockedProvider]);
  });

  testGoldens('Golden test home page volunteerings tab',
      (WidgetTester tester) async {
    await goldenTest(
        tester,
        HomePage(activeTabIndex: HomeTabs.volunteering.index),
        'home_page_volunteerings_tab',
        [userMockedProvider, volunteeringMockedProvider]);
  });

  testGoldens('Golden test home page initial tab', (WidgetTester tester) async {
    // to check that initial default tab didnt change
    await goldenTest(tester, HomePage(), 'home_page_default_tab',
        [userMockedProvider, volunteeringMockedProvider]);
  });

  testGoldens('Golden test news details page', (WidgetTester tester) async {
    await goldenTest(tester, const NewsDetailsPage(id: "1"),
        'news_details_page', [newsMockedProvider]);
  });

  testGoldens('Golden test volunteering details page',
      (WidgetTester tester) async {
    await goldenTest(
        tester,
        const VolunteeringDetailsPage(id: "1"),
        'volunteerings_detail_page',
        [userMockedProvider, volunteeringMockedProvider]);
  });
}
