import 'package:flutter/material.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/login_form.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';

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
                      _loginError = "";
                      // _loginError =
                      //     "Usuario y/o contraseña incorrectos."; // TODO: Assign api response
                    });

                    return;
                  }

                  UserModel? user = await SerManosApi().loginUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  Provider.of<UserProvider>(context, listen: false).user = user;

                  print(user);

                  //TODO: check credentials with backend
                  _loginError = 'false';
                  context.replaceNamed(SerManosPagesName.welcome);
                },
              ),
              const SerManosSizedBox.sm(),
              SerManosButton.longButton(
                text: 'No tengo cuenta',
                filled: false,
                onPressed: () {
                  context.replaceNamed(SerManosPagesName.signup);
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
