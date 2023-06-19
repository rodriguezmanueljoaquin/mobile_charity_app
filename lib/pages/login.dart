import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/loading_indicator.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/login_form.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/logger.dart';
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
  bool _loading = false;
  String _loginError = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _disabled = true;
        _loading = true;
      });
      await Provider.of<UserProvider>(context, listen: false)
          .login(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then((response) => {context.replaceNamed(SerManosPagesName.welcome)})
          .catchError((error) => setState(() {
                _loginError = error.toString();
              }));
      setState(() {
        _disabled = false;
        _loading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SerManosImages.full,
                    const SerManosSizedBox.lg(),
                    SerManosLoginForm(
                      formKey: _formKey,
                      onFieldSubmitted: _submit,
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
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: SerManosText.caption(
              _loginError,
              color: SerManosColors.error100,
            ),
          ),
          SerManosTextButton.longTextButton(
            text: 'Iniciar Sesión',
            disabled: _disabled,
            loading: _loading,
            onPressed: () async {
              _submit();
            },
          ),
          const SerManosSizedBox.sl(),
          SerManosTextButton.longTextButton(
            text: 'No tengo cuenta',
            filled: false,
            disabled: _loading,
            onPressed: () {
              context.replaceNamed(SerManosPagesName.signup);
            },
          ),
          const SerManosSizedBox.lg()
        ],
      ),
    );
  }
}
