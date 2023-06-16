import 'package:flutter/material.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/register_form.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
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
  String _registerError = '';

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar(toolbarHeight: 0).preferredSize.height,
          child: Column(
            children: [
              const SerManosSizedBox.lg(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SerManosImages.full,
                    const SerManosSizedBox.lg(),
                    SerManosRegisterForm(
                      formKey: _formKey,
                      changeDisabledStateTo: (bool state) {
                        setState(() {
                          _disabled = state;
                        });
                      },
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: SerManosText.caption(
                  _registerError,
                  color: SerManosColors.error100,
                ),
              ),
              SerManosTextButton.longTextButton(
                text: 'Registrarse',
                disabled: _disabled,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    setState(() {
                      _registerError =
                          "Este email ya ha sido utilizado."; // TODO: Assign api response
                    });
                    return;
                  }

                  //TODO: check credentials with backend
                  _registerError = 'false';

                  UserModel? user = await SerManosApi().registerUser(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(user!);

                  print(user);

                  context.replaceNamed(SerManosPagesName.welcome);
                },
              ),
              const SerManosSizedBox.sl(),
              SerManosTextButton.longTextButton(
                text: 'Ya tengo cuenta',
                filled: false,
                onPressed: () {
                  context.replaceNamed(SerManosPagesName.signin);
                },
              ),
              const SerManosSizedBox.lg(),
            ],
          ),
        ),
      ),
    );
  }
}
