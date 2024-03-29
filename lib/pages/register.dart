import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffolds.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/register_form.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/handle_exception.dart';
import 'package:provider/provider.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _disabled = true;
  bool _loading = false;
  String _registerError = '';

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _registerError = '';
    setState(() {
      _disabled = true;
      _loading = true;
    });
    await Provider.of<UserProvider>(context, listen: false)
        .register(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then((value) => context.replaceNamed(SerManosPagesName.welcome))
        .catchError(
          (error) => handleException(
            context: context,
            error: error,
            onFormException: (message) => setState(() {
              _registerError = message;
            }),
          ),
        );
    setState(() {
      _disabled = false;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SerManosDefaultScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 140,
              ),
              child: Center(
                child: Column(
                  children: [
                    const SerManosSizedBox.lg(),
                    SizedBox(width: 150, child: SerManosImages.full),
                    const SerManosSizedBox.lg(),
                    SerManosRegisterForm(
                      formKey: _formKey,
                      onFieldSubmitted: _submit,
                      changeDisabledStateTo: (bool state) {
                        setState(() {
                          _disabled = state;
                        });
                      },
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onFieldUpdated: () {
                        if (_registerError.isNotEmpty) {
                          setState(() {
                            _registerError = '';
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: SerManosSpacing.spaceSM),
              child: SerManosText.caption(
                _registerError,
                color: SerManosColors.error100,
              ),
            ),
            SerManosTextButton.longTextButton(
                text: 'Registrarse',
                disabled: _disabled,
                loading: _loading,
                onPressed: _submit),
            const SerManosSizedBox.sl(),
            SerManosTextButton.longTextButton(
              text: 'Ya tengo cuenta',
              filled: false,
              disabled: _loading,
              onPressed: () {
                context.replaceNamed(SerManosPagesName.signin);
              },
            ),
            const SerManosSizedBox.lg(),
          ],
        ),
      ),
    );
  }
}
