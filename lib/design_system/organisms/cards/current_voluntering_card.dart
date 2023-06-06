import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosCurrentVolunteringCard extends StatelessWidget {
  final String? title;

  const SerManosCurrentVolunteringCard({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: SerManosColors.primary5,
        border: Border.all(
          color: SerManosColors.primary100,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SerManosText.overline("ACCIÓN SOCIAL"),
              SerManosText.subtitle1(title ?? ""),
            ],
          ),
          Column(
            children: const [
              Center(
                child: SerManosIcon.location(
                  isPrimaryAction: true,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
