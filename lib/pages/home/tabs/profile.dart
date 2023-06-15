import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/information_card.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/personal_data_form.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SerManosSizedBox.lg(),
        const Center(
          child: SerManosProfilePhoto(url: null),
        ),
        const SerManosSizedBox.sm(),
        const SerManosGenderInputCard(),
        const SerManosSizedBox.sm(),
        SerManosInformationCard(
          title: "Información personal",
          contentsByLabel: Map.from({
            "Fecha de nacimiento": "12/12/1999",
            "Género": "Masculino",
          }),
        ),
        const SerManosSizedBox.sm(),
        const SerManosEditPhotoCard(currentPhotoUrl: "asd"),
        const SerManosSizedBox.sm(),
        SerManosPersonalDataForm(
            formKey: GlobalKey<FormState>(),
            changeDisabledStateTo: (bool state) {})
      ],
    ));
  }
}
