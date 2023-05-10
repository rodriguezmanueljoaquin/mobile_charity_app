import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';

import '../routes/paths.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

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
              context.replaceNamed(SerManosPagesName.signin);
            },
          ),
          const SerManosSizedBox.sl(),
          SerManosButton.longButton(
            text: 'Registrarse',
            filled: false,
            onPressed: () {
              context.replaceNamed(SerManosPagesName.signup);
            },
          ),
          const SerManosSizedBox.lg(),
        ],
      ),
    );
  }
}
