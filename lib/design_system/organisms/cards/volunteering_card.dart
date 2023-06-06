import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class SerManosVolunteeringCard extends StatefulWidget {
  final String category;
  final VolunteeringModel volunteering;

  const SerManosVolunteeringCard({
    super.key,
    required this.category,
    required this.volunteering,
  });

  @override
  State<SerManosVolunteeringCard> createState() =>
      _SerManosVolunteeringCardState();
}

class _SerManosVolunteeringCardState extends State<SerManosVolunteeringCard> {
  bool _isFavorite = false;

  Widget _buildInformation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SerManosText.overline(widget.category.toUpperCase()),
              SerManosText.subtitle1(widget.volunteering.title),
              const SerManosSizedBox.xs(),
              SerManosVacancies(
                vacancies: Random().nextInt(3),
              )
            ],
          ),
        ),
        Row(
          children: [
            SerManosIconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: SerManosIcon.favorite(
                state: _isFavorite,
                color: SerManosColors.primary100,
              ),
            ),
            const SerManosSizedBox.sl(useWidth: true, useHeight: false),
            SerManosIconButton(
              onPressed: () {},
              icon: const SerManosIcon.location(isPrimaryAction: true),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        SerManosPagesName.volunteeringDetail,
        pathParameters: {
          "id": widget.volunteering.id,
        },
        extra: widget.volunteering,
      ),
      child: Container(
        width: SerManosSizes.sizeLG,
        decoration: BoxDecoration(
          color: SerManosColors.neutral0,
          boxShadow: SerManosShadows.shadow2,
        ),
        child: Column(
          children: [
            Container(
              height: 138,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: SerManosImages.full.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SerManosSpacing.spaceSL,
                SerManosSpacing.spaceSM,
                SerManosSpacing.spaceSL,
                SerManosSpacing.spaceSL,
              ),
              child: _buildInformation(),
            )
          ],
        ),
      ),
    );
  }
}
