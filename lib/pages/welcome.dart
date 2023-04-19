import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
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
                SerManosText.subtitle1(
                  '"El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros"',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SerManosButton.longButton(
            text: 'Iniciar Sesión',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SerManosButton.longButton(
            text: 'Registrarse',
            filled: false,
            onPressed: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
