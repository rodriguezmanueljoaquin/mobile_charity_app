import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosUbicationCard extends StatefulWidget {
  final String address;

  const SerManosUbicationCard({
    super.key,
    required this.address,
  });

  @override
  State<SerManosUbicationCard> createState() => _SerManosUbicationCardState();
}

class _SerManosUbicationCardState extends State<SerManosUbicationCard> {
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
              child: SerManosText.subtitle1("Ubicación"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SerManosText.overline("DIRECCIÓN"),
                      SerManosText.body1(widget.address),
                    ],
                  ),
                  const Center(
                    child: SerManosIcon.location(
                      isPrimaryAction: true,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
