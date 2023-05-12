import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/routes/paths.dart';

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
                const SerManosSizedBox.lg(),
                SerManosText.headline1('¡Bienvenido!'),
                const SerManosSizedBox.xl(),
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
              context.replaceNamed(SerManosPagesName.volunteering);
            },
          ),
          const SizedBox(height: 92),
        ],
      ),
    );
  }
}
