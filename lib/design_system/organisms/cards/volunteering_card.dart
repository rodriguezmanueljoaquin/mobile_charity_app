import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';

class SerManosVolunteeringCard extends StatefulWidget {
  final VolunteeringModel volunteering;

  const SerManosVolunteeringCard({
    super.key,
    required this.volunteering,
  });

  @override
  State<SerManosVolunteeringCard> createState() =>
      _SerManosVolunteeringCardState();
}

class _SerManosVolunteeringCardState extends State<SerManosVolunteeringCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = Provider.of<UserProvider>(context, listen: false)
            .user
            ?.favoriteVolunteeringsIds
            ?.contains(widget.volunteering.id) ??
        false;
  }

  Widget _buildInformation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SerManosText.overline(widget.volunteering.category.toUpperCase()),
              SerManosText.subtitle1(widget.volunteering.title),
              const SerManosSizedBox.xs(),
              SerManosVacancies(
                vacancies: widget.volunteering.vacancies,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) => SerManosIconButton(
                onPressed: () {
                  userProvider.setVolunteeringAsFavorite(
                    volunteeringId: widget.volunteering.id,
                    isFavorite: !_isFavorite,
                  );

                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                icon: SerManosIcon.favorite(
                  state: _isFavorite,
                  color: SerManosColors.primary100,
                ),
              ),
            ),
            const SerManosSizedBox.sl(useWidth: true, useHeight: false),
            SerManosIconButton(
              onPressed: () {
                // open gmaps
                // GeoPoint location = widget.volunteering.location;
              },
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
        SerManosPagesName.volunteeringDetails,
        pathParameters: {
          "id": widget.volunteering.id,
        },
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
                  image: NetworkImage(widget.volunteering.imageURL),
                  fit: BoxFit.cover,
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
