import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? placeholder;
  final String? errorText;
  final bool disabled;
  final String? Function(String?)? validator;

  const SerManosTextFormField(
      {super.key,
      required this.controller,
      this.label,
      this.placeholder,
      this.validator,
      this.errorText,
      this.disabled = false});

  @override
  State<SerManosTextFormField> createState() => _SerManosTextFormFieldState();
}

class _SerManosTextFormFieldState extends State<SerManosTextFormField> {
  bool _hasError = false;

  String? Function(String?)? _validator() {
    return (String? value) {
      final errorMsg = widget.validator?.call(value);
      if(errorMsg!= null && !_hasError) {
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
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.placeholder,
          enabled: !widget.disabled,
          labelStyle: SerManosTextStyle.subtitle1(
            color:
                widget.disabled ? SerManosColors.neutral50 : 
                  _hasError? SerManosColors.error100 : SerManosColors.neutral75,
          ),
          hintStyle: SerManosTextStyle.subtitle1(
            color:
                widget.disabled ? SerManosColors.neutral50 : SerManosColors.neutral75, // TODO: should be secondary200 when focus
          ),
          errorStyle: const SerManosTextStyle.subtitle1(
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
