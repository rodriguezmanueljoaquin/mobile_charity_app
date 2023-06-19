import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/loading_indicator.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/indicators.dart';
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
  bool _loading = false;

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
            disabled: _loading,
            onPressed: () => Navigator.pop(context),
          ),
          const SerManosSizedBox.sm(
            useWidth: true,
          ),
          SerManosTextButton.shortTextButton(
            text: 'Confirmar',
            filled: false,
            disabled: _loading,
            loading: _loading,
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              await widget.onConfirm();
              setState(() {
                _loading = false;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
