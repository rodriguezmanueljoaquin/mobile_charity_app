import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/main.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_provider.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

void main() {
  testWidgets('entry login register flow test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); //load frame

    // --- ENTRY PAGE ---
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Registrarse'), findsOneWidget);
    await tester.tap(find.byKey(const Key('register-button')));
    await tester.pumpAndSettle(); //load frame

    // --- REGISTER PAGE ---
    expect(find.text('Registrarse'), findsOneWidget);
    expect(find.text('Ya tengo cuenta'), findsOneWidget);
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle(); //load frame

    // --- LOGIN PAGE ---
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

  testWidgets('home flow test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() =>
        tester.pumpWidget(MultiProvider(providers: [
          ChangeNotifierProvider<UserProvider>.value(value: MockUserProvider()),
          ChangeNotifierProvider<VolunteeringProvider>.value(
              value: MockVolunteeringProvider()),
          ChangeNotifierProvider<NewsProvider>.value(value: MockNewsProvider())
        ], child: MaterialApp(home: HomePage()))));
    await tester.pumpAndSettle(); //load frame

    // --- HOME PAGE VOLUNTEERING TAB ---
    expect(find.text('Postularse'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget);

    expect(find.byType(SerManosVolunteeringCard), findsWidgets);

    // --- HOME PAGE NEWS TAB ---
    // await tester.tap(find.text('Novedades'));
    // await tester.pump(const Duration(seconds: 1)); // finish the animation

    // expect(find.byType(SerManosNewsCard), findsWidgets);
  
    // --- HOME PAGE PROFILE TAB ---
    // await tester.ensureVisible(find.text('Mi perfil'));
    // await tester.tap(find.text('Mi perfil'));
    // await tester.pumpAndSettle(); //load frame
    // expect(find.byType(SerManosProfilePhoto), findsOneWidget);
  });
}
