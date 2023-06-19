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
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class NewsDetailsPage extends StatelessWidget {
  final String id;

  const NewsDetailsPage({
    super.key,
    required this.id,
  });

  Future<void> _onShare(BuildContext context, NewsModel news) async {
    final box = context.findRenderObject() as RenderBox?;
    final url = Uri.parse(news.imageURL);

    final imageRes = await http.get(url);
    XFile imageFile = XFile.fromData(imageRes.bodyBytes);

    await Share.shareXFiles([imageFile],
        text: news.summary,
        subject: news.title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, newsProvider, child) {
      if (newsProvider.news == null) {
        return const SerManosScaffold(
          applyPadding: false,
          whiteStatusBar: false,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      NewsModel news = newsProvider.getNewsById(id)!;

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
                    icon:
                        const SerManosIcon.back(color: SerManosColors.neutral0),
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
                        onPressed: () => _onShare(context, news),
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
    });
  }
}
