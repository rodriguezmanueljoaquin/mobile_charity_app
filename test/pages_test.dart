import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/main.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_provider.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

void main() {
  testWidgets('entry page test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EntryPage()));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Registrarse'), findsOneWidget);
  });

  testWidgets('register page test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Registrarse'), findsOneWidget);
    expect(find.text('Ya tengo cuenta'), findsOneWidget);
  });

  testWidgets('login page test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle(); //load frame

    Form formWidget = tester.widget(find.byType(Form));
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('No tengo cuenta'), findsOneWidget);
    expect(formKey.currentState!.validate(), isFalse);

    await tester.enterText(
        find.byKey(const Key('email-field')), 'asdadsad@asdasdasd.com');
    await tester.enterText(
        find.byKey(const Key('password-field')), 'asdasd121A%aaasd');
    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('home volunteerings test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() =>
        tester.pumpWidget(MultiProvider(providers: [
          ChangeNotifierProvider<UserProvider>.value(value: MockUserProvider()),
          ChangeNotifierProvider<VolunteeringProvider>.value(
              value: MockVolunteeringProvider()),
          ChangeNotifierProvider<NewsProvider>.value(value: MockNewsProvider())
        ], child: MaterialApp(home: HomePage()))));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Postularse'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget);

    expect(find.byType(SerManosVolunteeringCard), findsWidgets);
    expect(find.byType(SerManosProfilePhoto), findsNothing);
    expect(find.byType(SerManosNewsCard), findsNothing);
  });

  testWidgets('home news test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>.value(
                  value: MockUserProvider()),
              ChangeNotifierProvider<NewsProvider>.value(
                  value: MockNewsProvider())
            ],
            child: MaterialApp(
                home: HomePage(
              tab: 2,
            )))));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Postularse'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget);

    expect(find.byType(SerManosVolunteeringCard), findsNothing);
    expect(find.byType(SerManosProfilePhoto), findsNothing);
    expect(find.byType(SerManosNewsCard), findsWidgets);
  });

  testWidgets('home profile test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>.value(
                  value: MockUserProvider()),
              ChangeNotifierProvider<NewsProvider>.value(
                  value: MockNewsProvider())
            ],
            child: MaterialApp(
                home: HomePage(
              tab: 1,
            )))));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Postularse'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget);

    expect(find.byType(SerManosVolunteeringCard), findsNothing);
    expect(find.byType(SerManosProfilePhoto), findsOneWidget);
    expect(find.byType(SerManosNewsCard), findsNothing);
  });
}
