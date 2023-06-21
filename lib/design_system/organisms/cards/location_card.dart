import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/map.dart';

class SerManosLocationCard extends StatefulWidget {
  final VolunteeringModel volunteering;

  const SerManosLocationCard({
    super.key,
    required this.volunteering,
  });

  @override
  State<SerManosLocationCard> createState() => _SerManosLocationCardState();
}

class _SerManosLocationCardState extends State<SerManosLocationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 328,
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
              child: InkWell(
                onTap: () => showVolunteeringMap(widget.volunteering),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SerManosText.overline("DIRECCIÓN"),
                          SerManosText.body1(
                            widget.volunteering.address,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: SerManosIcon.location(
                        isPrimaryAction: true,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
