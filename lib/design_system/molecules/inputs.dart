import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/utils/logger.dart';
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
  final SerManosIcon? icon;
  final VoidCallback? iconOnPressed;
  final Function onFieldSubmitted;

  const SerManosTextFormField(
      {super.key,
      required this.controller,
      this.label,
      this.placeholder,
      this.validator,
      this.errorText,
      this.required = true,
      this.disabled = false,
      this.isPassword = false,
      this.icon,
      this.iconOnPressed,
      required this.onFieldSubmitted});

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
        onFieldSubmitted: (_) => widget.onFieldSubmitted(),
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
              : widget.icon != null
                  ? IconButton(
                      icon: widget.icon!,
                      onPressed: widget.iconOnPressed,
                      color: _hasError
                          ? SerManosColors.error100
                          : SerManosColors.primary100,
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
                    .neutral75, // TODO: should be secondary200 when focus?
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

class SerManosPhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final Function? onFieldSubmitted;

  const SerManosPhoneFormField(
      {super.key,
      required this.controller,
      this.placeholder,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Teléfono',
      placeholder: placeholder,
      onFieldSubmitted: onFieldSubmitted ?? () {},
      validator: phoneValidator,
    );
  }
}

class SerManosEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final Function? onFieldSubmitted;

  const SerManosEmailFormField(
      {super.key,
      required this.controller,
      this.placeholder,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Email',
      placeholder: placeholder,
      onFieldSubmitted: onFieldSubmitted ?? () {},
      validator: emailValidator,
    );
  }
}

class SerManosPasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final Function? onFieldSubmitted;

  const SerManosPasswordFormField(
      {super.key,
      required this.controller,
      this.placeholder,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Contraseña',
      placeholder: placeholder,
      validator: passwordValidator,
      onFieldSubmitted: onFieldSubmitted ?? () {},
      isPassword: true,
    );
  }
}

class SerManosDateFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const SerManosDateFormField(
      {super.key, required this.controller, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return SerManosTextFormField(
      controller: controller,
      label: 'Fecha de nacimiento',
      placeholder: 'DD/MM/YYYY',
      validator: dateValidator,
      isPassword: false,
      onFieldSubmitted: (_) {},
      icon: const SerManosIcon.calendar(
        isPrimaryAction: true,
      ),
      iconOnPressed: () async {
        var dateFormat = DateFormat('dd/MM/yyyy');
        DateTime _initialDate = DateTime.now();
        if (dateValidator(controller.text) == null) {
          _initialDate = dateFormat.parse(controller.text);
        }
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: _initialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: SerManosColors.primary100,
                  onPrimary: SerManosColors.neutral0,
                  surface: SerManosColors.neutral100,
                  onSurface: SerManosColors.neutral100,
                ),
                dialogBackgroundColor: SerManosColors.neutral0,
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          controller.text = dateFormat.format(date);
        }
      },
    );
  }
}

class SerManosSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function onFieldSubmitted;

  const SerManosSearchField(
      {super.key, required this.controller, required this.onFieldSubmitted});

  @override
  State<SerManosSearchField> createState() => _SerManosSearchFieldState();
}

class _SerManosSearchFieldState extends State<SerManosSearchField> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SerManosSizes.sizeLG,
      decoration: BoxDecoration(
        color: SerManosColors.neutral0,
        boxShadow: SerManosShadows.shadow1,
      ),
      // add white background
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        style: const SerManosTextStyle.subtitle1(),
        onChanged: (String value) {
          // avoid unnecessary setState => less rebuilds
          if (value.isNotEmpty && !_hasText) {
            setState(() {
              _hasText = true;
            });
          } else if (value.isEmpty && _hasText) {
            setState(() {
              _hasText = false;
            });
          }
        },
        onSubmitted: (_) => widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: 'Buscar',
          isCollapsed: true,
          suffixIcon: _hasText
              ? SerManosIconButton(
                  icon: const SerManosIcon.close(),
                  onPressed: () {
                    widget.controller.clear();
                    setState(() {
                      _hasText = false;
                    });
                  },
                )
              : SerManosIconButton(
                  icon: const SerManosIcon.search(),
                  onPressed: () => logger.i('Typing...'),
                ),
          contentPadding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: SerManosSpacing.spaceSL,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
