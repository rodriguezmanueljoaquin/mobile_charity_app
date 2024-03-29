import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';

class SerManosProfileDataForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;
  final String? currentPhotoUrl;
  final TextEditingController dateController;
  final Function(int) onGenderChange;
  final int? genderValue;
  final Function(File?) onImageChange;

  const SerManosProfileDataForm({
    super.key,
    required this.formKey,
    required this.changeDisabledStateTo,
    required this.dateController,
    required this.onGenderChange,
    required this.onImageChange,
    this.currentPhotoUrl,
    this.genderValue,
  });

  @override
  State<SerManosProfileDataForm> createState() =>
      _SerManosProfileDataFormState();
}

class _SerManosProfileDataFormState extends State<SerManosProfileDataForm> {
  late final TextEditingController _dateController;
  bool _allowSubmission = false;
  bool _genderSelected = false;

  @override
  void initState() {
    super.initState();
    _genderSelected = widget.genderValue != null;
    _dateController = widget.dateController;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if (_dateController.text.isNotEmpty && _genderSelected) {
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
          SerManosDateFormField(
            controller: _dateController,
          ),
          const SerManosSizedBox.md(),
          SerManosGenderInputCard(
              onGenderChange: (value) {
                _genderSelected = true;
                widget.onGenderChange(value);
                _inputListener(); // force check to enable form submission
              },
              value: widget.genderValue),
          const SerManosSizedBox.md(),
          SerManosEditPhotoCard(
            currentPhotoUrl: widget.currentPhotoUrl,
            onChange: (value) {
              widget.onImageChange(value);
              _inputListener(); // force check to enable form submission
            },
          )
        ],
      ),
    );
  }
}
