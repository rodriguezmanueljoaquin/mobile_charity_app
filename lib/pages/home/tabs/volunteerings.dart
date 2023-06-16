import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/availability.dart';
import 'package:mobile_charity_app/models/volunteering.dart';

class VolunteeringsTab extends StatelessWidget {
  const VolunteeringsTab({
    super.key,
    required this.searchController,
    required this.currentVolunteeringTitle,
  });

  final TextEditingController searchController;
  final String? currentVolunteeringTitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SerManosSizedBox.lg(),
        SerManosSearchField(controller: searchController),
        const SerManosSizedBox.lg(),
        if (currentVolunteeringTitle != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SerManosText.headline1("Tu actividad"),
              const SerManosSizedBox.sl(),
              SerManosCurrentVolunteringCard(
                title: currentVolunteeringTitle,
              ),
              const SerManosSizedBox.md(),
            ],
          ),
        SizedBox(
          width: SerManosSizes.sizeLG,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SerManosText.headline1("Voluntariados"),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: SerManosSpacing.spaceSL,
            vertical: SerManosSpacing.spaceMD,
          ),
          itemBuilder: (context, index) {
            return UnconstrainedBox(
              child: SerManosVolunteeringCard(
                // TODO: Remove hardcoded data
                volunteering: VolunteeringModel(
                    id: '1',
                    title: 'Un Techo para mi País',
                    description:
                        'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                    imageURL: 'https://via.placeholder.com/150',
                    category: "Acción Social",
                    about:
                        'Un Techo para mi País es una organización latinoamericana que busca superar la situación de pobreza que viven miles de personas en los asentamientos precarios, a través de la acción conjunta de sus habitantes y jóvenes voluntarios y voluntarias. Para esto, trabajamos en la construcción de viviendas de emergencia, la ejecución de programas de educación y trabajo, y la incidencia en políticas públicas.',
                    address: "Cabildo 600",
                    requirements: [
                      "Ser mayor de 18 años",
                      "Tener disponibilidad para participar de la actividad",
                      "Tener ganas de ayudar",
                    ],
                    availability: [
                      Availability(dayOfWeek: 1, startHour: 12, endHour: 13)
                    ],
                    vacancies: 5,
                    createdAt: DateTime.now(),
                    volunteerIds: ["1"],
                    location: GeoPoint(1, 1)),
              ),
            );
          },
          separatorBuilder: (context, index) => const SerManosSizedBox.md(),
          itemCount: 5,
        ),
      ],
    ));
  }
}
