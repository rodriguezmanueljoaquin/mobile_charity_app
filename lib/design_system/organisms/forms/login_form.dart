import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.formKey,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _allowSubmittion = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _allowSubmittion = widget.formKey.currentState!.validate();
      });
    } else if (_allowSubmittion) {
      setState(() {
        _allowSubmittion = false;
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
            controller: _emailController,
            placeholder: 'Ingrese su email',
          ),
          const SerManosSizedBox.sm(),
          SerManosPasswordFormField(
            controller: _passwordController,
            placeholder: 'Ingrese su contraseña',
          ),
        ],
      ),
    );
  }
}
