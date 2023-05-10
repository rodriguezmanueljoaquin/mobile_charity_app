import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/login_form.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/welcome.dart';

import '../design_system/tokens/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _disabled = true;
  String _loginError = '';

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar(toolbarHeight: 0).preferredSize.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SerManosLogos.full,
                    const SerManosSizedBox.lg(),
                    LoginForm(
                      formKey: _formKey,
                      changeDisabledStateTo: (bool state) {
                        setState(() {
                          _disabled = state;
                        });
                      },
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SerManosText.caption(
                  _loginError,
                  color: SerManosColors.error100,
                ),
              ),
              SerManosButton.longButton(
                text: 'Iniciar Sesión',
                disabled: _disabled,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    setState(() {
                      _loginError =
                          "Usuario y/o contraseña incorrectos."; // TODO: Assign api response
                    });

                    return;
                  }

                  UserCredential credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);

                  print(credential.user!.email);

                  //TODO: check credentials with backend
                  _loginError = 'false';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const WelcomePage();
                      },
                    ),
                  );
                },
              ),
              const SerManosSizedBox.sm(),
              SerManosButton.longButton(
                text: 'No tengo cuenta',
                filled: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const RegisterPage();
                      },
                    ),
                  );
                },
              ),
              const SerManosSizedBox.lg()
            ],
          ),
        ),
      ),
    );
  }
}
