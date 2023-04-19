import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/utils/validators.dart';

class SerManosTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? placeholder;
  final String? errorText;
  final bool disabled;
  final bool required;
  final String? Function(String?)? validator;
  final bool isPassword;

  const SerManosTextFormField(
      {super.key,
      required this.controller,
      this.label,
      this.placeholder,
      this.validator,
      this.errorText,
      this.required = true,
      this.disabled = false,
      this.isPassword = false});

  @override
  State<SerManosTextFormField> createState() => _SerManosTextFormFieldState();
}

class _SerManosTextFormFieldState extends State<SerManosTextFormField> {
  bool _hasError = false;
  bool _visible = false;

  @override
  void initState() {
    _visible = !widget.isPassword;
    super.initState();
  }

  String? Function(String?)? _validator() {
    return (String? value) {
      if (widget.required && (value == null || value.isEmpty)) {
        Future.delayed(Duration.zero, () {
          setState(() {
            _hasError = true;
          });
        });
        return 'Este campo es requerido';
      }

      final errorMsg = widget.validator?.call(value);
      if (errorMsg != null && !_hasError) {
        Future.delayed(Duration.zero, () {
          setState(() {
            _hasError = true;
          });
        });
      } else if (errorMsg == null && _hasError) {
        Future.delayed(Duration.zero, () {
          setState(() {
            _hasError = false;
          });
        });
      }
      return errorMsg;
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 328,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        validator: _validator(),
        obscureText: !_visible,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.placeholder,
          enabled: !widget.disabled,
          contentPadding: const EdgeInsets.only(
            left: 16,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: SerManosIcon.visibility(
                    state: _visible,
                    color: _hasError
                        ? SerManosColors.error100
                        : SerManosColors.neutral75,
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = !_visible;
                    });
                  },
                )
              : _hasError
                  ? const SerManosIcon.error()
                  : null,
          labelStyle: SerManosTextStyle.subtitle1(
            color: widget.disabled
                ? SerManosColors.neutral50
                : _hasError
                    ? SerManosColors.error100
                    : SerManosColors.neutral75,
          ),
          hintStyle: SerManosTextStyle.subtitle1(
            color: widget.disabled
                ? SerManosColors.neutral50
                : SerManosColors
                    .neutral75, // TODO: should be secondary200 when focus
          ),
          errorStyle: const SerManosTextStyle.body2(
            color: SerManosColors.error100,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: SerManosColors.neutral75,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: SerManosColors.neutral50,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: SerManosColors.secondary200,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: SerManosColors.error100,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: SerManosColors.error100,
            ),
          ),
        ),
      ),
    );
  }
}

class SerManosEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const SerManosEmailFormField(
      {super.key, required this.controller, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Email',
      placeholder: placeholder,
      validator: emailValidator,
    );
  }
}

class SerManosPasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const SerManosPasswordFormField(
      {super.key, required this.controller, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Contraseña',
      placeholder: placeholder,
      validator: passwordValidator,
      isPassword: true,
    );
  }
}
