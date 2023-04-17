import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _allowSubmittion = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _allowSubmittion = _formKey.currentState!.validate();
      });      
    } else if (_allowSubmittion) {
      setState(() {_allowSubmittion = false;});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SerManosLogos.full,
          const SizedBox(height: 32.0),
          Form(
            key: _formKey,
            onChanged: _inputListener,
            child: Column(
              children: [
                SerManosTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  placeholder: 'Ingrese su email',
                  validator: emailValidator,
                  errorText: _emailError,
                ),
                const SizedBox(height: 16.0),
                SerManosTextFormField( // TODO password text field
                  controller: _passwordController,
                  label: 'Contraseña',
                  placeholder: 'Ingrese su contraseña',
                  validator: passwordValidator,
                  errorText: _passwordError,
                ),
                const SizedBox(height: 16.0),
                SerManosButton.longButton(
                  text: 'Iniciar Sesión',
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   Navigator.pushNamed(context, '/home');
                    // }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
