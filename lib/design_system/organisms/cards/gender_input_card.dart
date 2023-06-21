import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/molecules/radio_list_tile.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/utils/genders_constants.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosGenderInputCard extends StatefulWidget {
  final Function(int) onGenderChange;
  final int? value;

  const SerManosGenderInputCard({
    super.key,
    required this.onGenderChange,
    this.value,
  });

  @override
  State<SerManosGenderInputCard> createState() =>
      _SerManosGenderInputCardState();
}

class _SerManosGenderInputCardState extends State<SerManosGenderInputCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 328,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          color: SerManosColors.neutral10,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                color: SerManosColors.secondary25,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: SerManosSpacing.spaceSM, horizontal: 16),
              child: SerManosText.subtitle1("Información de perfil"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: SerManosSpacing.spaceSM, horizontal: 16),
              child: SerManosRadioListTile(
                  options: genderStrById,
                  onGenderChange: widget.onGenderChange,
                  value: widget.value),
            )
          ],
        ));
  }
}
