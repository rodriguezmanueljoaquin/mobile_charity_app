import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class VolunteeringCard extends StatefulWidget {
  final String category;
  final String title;
  final Function(bool)? onFavorite;

  const VolunteeringCard({
    super.key,
    required this.category,
    required this.title,
    this.onFavorite,
  });

  @override
  State<VolunteeringCard> createState() => _VolunteeringCardState();
}

class _VolunteeringCardState extends State<VolunteeringCard> {
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
              SerManosText.subtitle1(widget.title),
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
                widget.onFavorite?.call(_isFavorite);
              },
              icon: SerManosIcon.favorite(
                state: _isFavorite,
                color: SerManosColors.primary100,
              ),
            ),
            const SerManosSizedBox.sl(useWidth: true, useHeight: false),
            SerManosIconButton(
              onPressed: () {},
              icon: const SerManosIcon.location(
                state: true,
                color: SerManosColors.primary100,
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
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
                image: SerManosLogos.full.image,
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
    );
  }
}
