import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class VolunteeringModal extends StatelessWidget {
  final String title;
  final String schedules;
  final String location;

  const VolunteeringModal({
    super.key,
    required this.title,
    required this.schedules,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: SerManosShadows.shadow3),
      child: AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(
          SerManosSpacing.spaceSL,
          SerManosSpacing.spaceSL,
          SerManosSpacing.spaceSL,
          SerManosSpacing.spaceSM,
        ),
        actionsPadding: const EdgeInsets.only(
          right: SerManosSpacing.spaceSL,
          bottom: SerManosSpacing.spaceSM,
        ),
        buttonPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SerManosText.subtitle1('Te estás por postular a'),
              SerManosText.headline2(title),
              const SerManosSizedBox.sl(),
              SerManosText.body1('Días $schedules'),
              const SerManosSizedBox.height(height: 2),
              SerManosText.body1(location),
            ],
          ),
        ),
        actions: [
          SerManosButton.shortTextButton(
            text: 'Cancelar',
            filled: false,
            onPressed: () => Navigator.pop(context),
          ),
          SerManosButton.shortTextButton(
            text: 'Confirmar',
            filled: false,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}