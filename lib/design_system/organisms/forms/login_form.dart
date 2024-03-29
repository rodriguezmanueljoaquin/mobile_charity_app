import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';

class SerManosLoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onFieldSubmitted;
  final Function onFieldUpdated;

  const SerManosLoginForm(
      {super.key,
      required this.formKey,
      required this.changeDisabledStateTo,
      required this.emailController,
      required this.passwordController,
      required this.onFieldSubmitted,
      required this.onFieldUpdated});

  @override
  State<SerManosLoginForm> createState() => _SerManosLoginFormState();
}

class _SerManosLoginFormState extends State<SerManosLoginForm> {
  // controllers
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _allowSubmission = false;

  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController;
    _passwordController = widget.passwordController;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _inputListener() {
    widget.onFieldUpdated();
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
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
      child: Column(
        children: [
          SerManosEmailFormField(
            key: const Key('email-field'),
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: _emailController,
            placeholder: 'Ingrese su email',
          ),
          const SerManosSizedBox.sm(),
          SerManosPasswordFormField(
            key: const Key('password-field'),
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: _passwordController,
            placeholder: 'Ingrese su contraseña',
          ),
        ],
      ),
    );
  }
}
