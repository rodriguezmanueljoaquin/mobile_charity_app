import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final String errorText;
  final bool disabled;

  const SerManosTextFormField(
      {super.key,
      required this.controller,
      this.label = '',
      this.placeholder = '',
      this.errorText = '',
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 328,
      child: _SerManosTextFormField(
        controller: controller,
        label: label,
        placeholder: placeholder,
        errorText: errorText,
        disabled: disabled,
      ),
    );
  }
}

class _SerManosTextFormField extends TextFormField {
  _SerManosTextFormField({
    required String label,
    required TextEditingController controller,
    String placeholder = '',
    String errorText = '',
    bool disabled = false,
  }) : super(
          controller: controller,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            hintText: placeholder,
            enabled: !disabled,
            labelStyle: SerManosTextStyle.subtitle1(
              color: disabled
                  ? SerManosColors.neutral50
                  : SerManosColors.neutral75,
            ),
            hintStyle: SerManosTextStyle.subtitle1(
              color: disabled
                  ? SerManosColors.neutral50
                  : SerManosColors.neutral75,
            ),
            errorStyle: SerManosTextStyle.subtitle1(
              color: disabled
                  ? SerManosColors.neutral50
                  : SerManosColors.neutral75,
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
        );
}
