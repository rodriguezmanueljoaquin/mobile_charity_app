import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/register_form.dart';
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
              SerManosButton.longTextButton(
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
                      context.replaceNamed(SerManosPagesName.welcome);
                    }
                  }
                },
              ),
              const SerManosSizedBox.sl(),
              SerManosButton.longTextButton(
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
