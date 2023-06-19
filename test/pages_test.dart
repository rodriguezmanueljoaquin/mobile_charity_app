import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/modals/volunteering_modal.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/pages/entry.dart';
import 'package:mobile_charity_app/pages/home/home.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/volunteering_details.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/routes/home_tabs.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_provider.dart';
import 'mocks/mock_user_provider.dart';
import 'mocks/mock_userfull_provider.dart';
import 'mocks/mock_volunteering_provider.dart';

void volunteeringDetailsModalTest(
    WidgetTester tester,
    String volunteeringId,
    UserProvider userProvider,
    openModalButtonText,
    String modalText,
    Function extraExpectBeforeModal,
    bool modalHasVolunteeringTitle) async {
  await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<UserProvider>.value(value: userProvider),
            ChangeNotifierProvider<VolunteeringProvider>.value(
                value: MockVolunteeringProvider()),
          ],
          child: MaterialApp(
              home: VolunteeringDetailsPage(
            id: volunteeringId,
          )))));
  await tester.pumpAndSettle(); //load frame
  VolunteeringModel modelExpected =
      MockVolunteeringProvider().getVolunteeringById(volunteeringId)!;

  expect(find.text(modelExpected.title), findsOneWidget);
  expect(find.text(modelExpected.description), findsOneWidget);
  expect(find.text(modelExpected.about), findsOneWidget);
  expect(find.text(modelExpected.address), findsOneWidget);
  expect(find.text(modelExpected.category.toUpperCase()), findsOneWidget);

  expect(find.byType(SerManosVolunteeringModal), findsNothing);
  await extraExpectBeforeModal();
  await tester.tap(find.text(openModalButtonText));
  await tester.pumpAndSettle();

  expect(find.byType(SerManosVolunteeringModal), findsOneWidget);
  expect(find.text(modalText), findsOneWidget);
  if (modalHasVolunteeringTitle) {
    expect(find.text(modelExpected.title),
        findsNWidgets(2)); // one from modal and one from details
  }

  await tester.tap(find.text('Cancelar'));
  await tester.pumpAndSettle();

  expect(find.byType(SerManosVolunteeringModal), findsNothing);
}

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
              activeTabIndex: HomeTabs.news.index,
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
              activeTabIndex: HomeTabs.profile.index,
            )))));
    await tester.pumpAndSettle(); //load frame

    expect(find.text('Postularse'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget);

    expect(find.byType(SerManosVolunteeringCard), findsNothing);
    expect(find.byType(SerManosProfilePhoto), findsOneWidget);
    expect(find.byType(SerManosNewsCard), findsNothing);
  });

  testWidgets(
      'volunteering details modal not current volunteering and profile not completed test',
      (WidgetTester tester) async {
    String volunteeringId = "2";
    volunteeringDetailsModalTest(
        tester,
        volunteeringId,
        MockUserProvider(),
        'Postularme',
        'Para postularte debes primero completar tus datos.',
        () => {},
        false);
  });

  testWidgets(
      'volunteering details modal not current volunteering and profile completed test',
      (WidgetTester tester) async {
    String volunteeringId = "2";
    volunteeringDetailsModalTest(tester, volunteeringId, MockUserFullProvider(),
        'Postularme', 'Te estás por postular a', () => {}, true);
  });

  testWidgets('volunteering details modal current volunteering test',
      (WidgetTester tester) async {
    String volunteeringId =
        (MockUserFullProvider().user?.currentVolunteeringId)!;
    volunteeringDetailsModalTest(
        tester,
        volunteeringId,
        MockUserFullProvider(),
        'Retirar postulación',
        '¿Estás seguro que querés retirar tu postulación?',
        () => expect(find.text('Te has postulado'), findsOneWidget),
        true);
  });

  testWidgets(
      'volunteering details modal different from current volunteering test',
      (WidgetTester tester) async {
    String volunteeringId = "3";
    volunteeringDetailsModalTest(
        tester,
        volunteeringId,
        MockUserFullProvider(),
        'Abandonar voluntariado actual',
        '¿Estás seguro que querés abandonar tu voluntariado?',
        () => expect(
            find.text(
                'Ya estas participando en otro voluntariado, debes abandonarlo primero para postularte a este.'),
            findsOneWidget),
        true);
  });
}
