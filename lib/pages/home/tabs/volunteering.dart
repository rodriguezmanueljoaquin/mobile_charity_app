import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';

class VolunteeringTab extends StatelessWidget {
  const VolunteeringTab({
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
            return const UnconstrainedBox(
              child: SerManosVolunteeringCard(
                // TODO: Remove hardcoded data
                category: 'Acción Social',
                volunteering: VolunteeringModel(
                  id: '1',
                  title: 'Un Techo para mi País',
                  description:
                      'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                ),
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
