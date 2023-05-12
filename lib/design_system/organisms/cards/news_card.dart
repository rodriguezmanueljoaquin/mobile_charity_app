import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class NewsCard extends StatelessWidget {
  final String overline;
  final String title;
  final String body;

  const NewsCard({
    super.key,
    required this.overline,
    required this.title,
    required this.body,
  });

  Widget _buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SerManosText.overline(overline.toUpperCase()),
            SerManosText.subtitle1(title),
            SerManosText.body2(body),
          ],
        ),
        const SerManosSizedBox.sm(),
        Align(
          alignment: Alignment.centerRight,
          child: SerManosButton.shortTextButton(
            text: 'Leer Más',
            onPressed: () {},
            filled: false,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SerManosSizes.sizeLG,
      decoration: BoxDecoration(
        color: SerManosColors.neutral0,
        boxShadow: SerManosShadows.shadow2,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 118,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: SerManosLogos.full.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: SerManosSpacing.spaceSM,
                    left: SerManosSpacing.spaceSM,
                    top: SerManosSpacing.spaceSL,
                  ),
                  child: _buildInformation(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
