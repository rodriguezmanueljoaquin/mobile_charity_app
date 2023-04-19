import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/register_form.dart';
import 'package:mobile_charity_app/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SerManosSizedBox.height(height: 31),
            SerManosLogos.full,
            const SerManosSizedBox.height(height: 31),
            Form(
              key: formKey,
              child: RegisterForm(formKey: formKey),
            ),
            const SerManosSizedBox.height(height: 104),
            SerManosButton.longButton(
              text: 'Registrarse',
              onPressed: () {},
            ),
            const SerManosSizedBox.sl(),
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
            const SerManosSizedBox.lg()
          ],
        ),
      ),
    );
  }
}
