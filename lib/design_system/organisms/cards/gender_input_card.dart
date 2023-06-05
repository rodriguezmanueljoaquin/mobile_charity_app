import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/molecules/radio_list_tile.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

Map<int, String> gendersById =
    HashMap.from({0: "Hombre", 2: "Mujer", 3: "No binario"});

class SerManosGenderInputCard extends StatefulWidget {
  const SerManosGenderInputCard({
    super.key,
  });

  @override
  State<SerManosGenderInputCard> createState() =>
      _SerManosGenderInputCardState();
}

class _SerManosGenderInputCardState extends State<SerManosGenderInputCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 328,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: SerManosColors.neutral10,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: SerManosColors.secondary25,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SerManosText.subtitle1("Información de perfil"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SerManosRadioListTile(options: gendersById),
            )
          ],
        ));
  }
}
