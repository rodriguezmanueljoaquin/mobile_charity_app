import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosContactDataForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;

  const SerManosContactDataForm(
      {super.key, required this.formKey, required this.changeDisabledStateTo});

  @override
  State<SerManosContactDataForm> createState() =>
      _SerManosContactDataFormState();
}

class _SerManosContactDataFormState extends State<SerManosContactDataForm> {
  // controllers
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? imageUrl;
  bool _allowSubmission = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if (_phoneController.text.isNotEmpty && _emailController.text.isNotEmpty) {
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
          SizedBox(
            width: SerManosSizes.sizeLG,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SerManosText.headline1("Datos de contacto"),
                const SerManosSizedBox.md(),
                SerManosText.subtitle1(
                    "Estos datos serán compartidos con la organización para ponerse en contacto contigo"),
              ],
            ),
          ),
          const SerManosSizedBox.sl(),
          SerManosPhoneFormField(controller: _phoneController),
          const SerManosSizedBox.sl(),
          SerManosEmailFormField(controller: _emailController),
        ],
      ),
    );
  }
}
