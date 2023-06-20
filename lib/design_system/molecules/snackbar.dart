import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosSnackBar {
  final SnackBar _snackBar;

  SerManosSnackBar(String message)
      : _snackBar = SnackBar(
          backgroundColor: SerManosColors.black,
          content: SerManosText.body1(message, color: SerManosColors.neutral10),
          action: SnackBarAction(
            textColor: SerManosColors.secondary80,
            label: 'Cerrar',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

  SnackBar get snackBar => _snackBar;

  void show(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
}
