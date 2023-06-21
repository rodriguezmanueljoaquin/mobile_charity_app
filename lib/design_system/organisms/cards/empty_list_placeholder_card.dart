import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosEmptyListPlaceholderCard extends StatelessWidget {
  final String text;
  const SerManosEmptyListPlaceholderCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SerManosColors.neutral0,
        borderRadius: BorderRadius.circular(4),
      ),
      // width: SerManosSizes.sizeLG,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 18, horizontal: SerManosSpacing.spaceMD),
        child: SerManosText.subtitle1(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
