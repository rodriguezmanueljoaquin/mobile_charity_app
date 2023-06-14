import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';

class SerManosPersonalDataForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool) changeDisabledStateTo;

  const SerManosPersonalDataForm(
      {super.key, required this.formKey, required this.changeDisabledStateTo});

  @override
  State<SerManosPersonalDataForm> createState() =>
      _SerManosPersonalDataFormState();
}

class _SerManosPersonalDataFormState extends State<SerManosPersonalDataForm> {
  // controllers
  final _dateController = TextEditingController();
  String? imageUrl;
  bool _allowSubmission = false;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _inputListener() {
    if (_dateController.text.isNotEmpty) {
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
          const SerManosGenderInputCard(),
          const SerManosSizedBox.md(),
          SerManosEditPhotoCard(
            currentPhotoUrl: imageUrl,
          )
        ],
      ),
    );
  }
}
