import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/news.dart';

class NewsDetailsPage extends StatelessWidget {
  final NewsModel news;
  final String id;

  const NewsDetailsPage({
    super.key,
    required this.id,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      applyPadding: false,
      whiteStatusBar: false,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            color: SerManosColors.secondary90,
            child: Row(
              children: [
                SerManosIconButton(
                  icon: const SerManosIcon.back(color: SerManosColors.neutral0),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: SerManosText.subtitle1("Novedades",
                      textAlign: TextAlign.center,
                      color: SerManosColors.neutral0),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: SerManosSizes.sizeLG,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SerManosSizedBox.md(),
                    SerManosText.overline(news.source,
                        textAlign: TextAlign.left),
                    SerManosText.headline2(news.title,
                        textAlign: TextAlign.left),
                    const SerManosSizedBox.sl(),
                    Image.network(
                      news.imageURL,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosText.body1(
                      news.summary,
                      color: SerManosColors.secondary200,
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosText.body1(news.description),
                    const SerManosSizedBox.sl(),
                    Center(
                      child: SerManosText.headline1(
                        "Comparte esta nota",
                      ),
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosTextButton.longTextButton(
                      text: 'Compartir',
                      onPressed: () {}, // TODO: deeplink
                    ),
                    const SerManosSizedBox.lg(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
