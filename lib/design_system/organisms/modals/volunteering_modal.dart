import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';

class SerManosVolunteeringModal extends StatefulWidget {
  final VolunteeringModel volunteering;
  final String title;
  final Function onConfirm;

  const SerManosVolunteeringModal(
      {super.key,
      required this.volunteering,
      required this.title,
      required this.onConfirm});

  @override
  State<SerManosVolunteeringModal> createState() =>
      _SerManosVolunteeringModalState();
}

class _SerManosVolunteeringModalState extends State<SerManosVolunteeringModal> {
  bool _disabled = false;

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
              SerManosText.subtitle1(widget.title),
              SerManosText.headline2(widget.volunteering.title),
            ],
          ),
        ),
        actions: [
          SerManosTextButton.shortTextButton(
            text: 'Cancelar',
            filled: false,
            onPressed: () => Navigator.pop(context),
          ),
          SerManosTextButton.shortTextButton(
            text: 'Confirmar',
            filled: false,
            disabled: _disabled,
            onPressed: () async {
              setState(() {
                _disabled = true;
              });
              await widget.onConfirm();
              setState(() {
                _disabled = false;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
