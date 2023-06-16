import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';

class SerManosRegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SerManosRegisterForm(
      {super.key,
      required this.formKey,
      required this.changeDisabledStateTo,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.passwordController});

  @override
  State<SerManosRegisterForm> createState() => _SerManosRegisterFormState();
}

class _SerManosRegisterFormState extends State<SerManosRegisterForm> {
  // controllers
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _allowSubmission = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = widget.firstNameController;
    _lastNameController = widget.lastNameController;
    _emailController = widget.emailController;
    _passwordController = widget.passwordController;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      bool isValid = widget.formKey.currentState!.validate();
      widget.changeDisabledStateTo(!isValid);
      setState(() {
        _allowSubmission = isValid;
      });
    } else if (_allowSubmission) {
      widget.changeDisabledStateTo(true);
      setState(() {
        _allowSubmission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        onChanged: _inputListener,
        child: Column(children: [
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
        ]));
  }
}
