import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/shadows.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class SerManosNewsCard extends StatelessWidget {
  final NewsModel news;

  const SerManosNewsCard({
    super.key,
    required this.news,
  });

  Widget _buildInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SerManosText.overline(news.source),
            SerManosText.subtitle1(news.title),
            SerManosText.body2(
              news.summary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const SerManosSizedBox.sm(),
        Align(
          alignment: Alignment.centerRight,
          child: SerManosTextButton.shortTextButton(
            text: 'Leer Más',
            onPressed: () => context.pushNamed(
              SerManosPagesName.newsDetails,
              pathParameters: {
                "id": news.id,
              },
            ),
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
                  image: Image.network(news.downloadImageURL!).image,
                  fit: BoxFit.cover,
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
                child: _buildInformation(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
