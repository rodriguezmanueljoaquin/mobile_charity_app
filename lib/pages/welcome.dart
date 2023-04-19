import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/main.dart';
import 'package:mobile_charity_app/pages/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SerManosLogos.full,
                const SizedBox(height: 30),
                SerManosText.headline1('¡Bienvenido!'),
                const SizedBox(height: 48),
                SerManosText.subtitle1(
                  'Nunca subestimes tu habilidad para mejorar la vida de alguien.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SerManosButton.longButton(
            text: 'Comenzar',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 92),
        ],
      ),
    );
  }
}
