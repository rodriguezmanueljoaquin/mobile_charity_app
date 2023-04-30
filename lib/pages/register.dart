import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/register_form.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/welcome.dart';

import '../design_system/tokens/colors.dart';
import '../design_system/tokens/typography.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _disabled = true;
  String _registerError = '';

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SerManosSizedBox.lg(),
          SerManosLogos.full,
          const SerManosSizedBox.lg(),
          RegisterForm(
            formKey: _formKey,
            changeDisabledStateTo: (bool state) {
              setState(() {
                _disabled = state;
              });
            },
          ),
          const SerManosSizedBox.height(height: 104),
          SerManosButton.longButton(
            text: 'Registrarse',
            disabled: _disabled,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _registerError =
                      "Este email ya ha sido utilizado."; // TODO: Assign api response
                });

                if (_registerError.isEmpty) {
                  //TODO: check credentials with backend
                  _registerError = 'false';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const WelcomePage();
                      },
                    ),
                  );
                }
              }
            },
          ),
          if (_registerError.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: SerManosText.caption(
                _registerError,
                color: SerManosColors.error100,
              ),
            ),
          SerManosButton.longButton(
            text: 'Ya tengo cuenta',
            filled: false,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
          const SerManosSizedBox.lg(),
        ]),
      ),
    );
  }
}
