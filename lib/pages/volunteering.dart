import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/modals/volunteering_modal.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class VolunteeringPage extends StatelessWidget {
  final String description;
  final String title;

  const VolunteeringPage({
    super.key,
    required this.description,
    required this.title,
  });

  Function _showDialog({required BuildContext context}) {
    return () => showDialog(
          context: context,
          builder: (BuildContext context) => VolunteeringModal(
            title: title,
            schedules: 'Sábados de 9.00 a 17.00 horas',
            location: 'Caballito',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      applyPadding: false,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 243,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: SerManosLogos.full.image,
                    fit: BoxFit.contain,
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.0, 0.3555],
                  ),
                ),
              ),
              Positioned(
                top: SerManosSpacing.spaceMD,
                left: SerManosSpacing.spaceMD,
                child: SerManosIconButton(
                  icon: const SerManosIcon.back(color: SerManosColors.neutral0),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SerManosSpacing.spaceSL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SerManosText.headline1(title),
                  const SerManosSizedBox.md(),
                  SerManosText.body1(description),
                ],
              ),
            ),
          ),
          SerManosButton.longButton(
            text: 'Postularme',
            onPressed: _showDialog(context: context),
            onLongPress: _showDialog(context: context),
          ),
          const SerManosSizedBox.height(height: 56),
        ],
      ),
    );
  }
}
