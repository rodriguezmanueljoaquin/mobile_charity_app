import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';

class SerManosLoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;

  const SerManosLoginForm(
      {super.key, required this.formKey, required this.changeDisabledStateTo});

  @override
  State<SerManosLoginForm> createState() => _SerManosLoginFormState();
}

class _SerManosLoginFormState extends State<SerManosLoginForm> {
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _allowSubmission = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _inputListener() {
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
