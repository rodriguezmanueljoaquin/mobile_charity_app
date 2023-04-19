import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const RegisterForm({
    super.key,
    required this.formKey,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SerManosTextFormField(
        controller: _firstNameController,
        label: 'Nombre',
        placeholder: 'Ej: Juan',
      ),
      const SerManosSizedBox.sm(),
      SerManosTextFormField(
        controller: _lastNameController,
        label: 'Apellido',
        placeholder: 'Ej: Barcena',
      ),
      const SerManosSizedBox.sm(),
      SerManosEmailFormField(
        controller: _emailController,
        placeholder: 'Ej: juanbarcena@mail.com',
      ),
      const SerManosSizedBox.sm(),
      SerManosPasswordFormField(
        controller: _passwordController,
        placeholder: 'Ej: ABCD1234',
      ),
    ]);
  }
}
