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

class NewsDetailsPage extends StatefulWidget {
  final String id;

  const NewsDetailsPage({
    super.key,
    required this.id,
  });

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  late final NewsModel _news;

  @override
  void initState() {
    super.initState();
    // TODO: check: if result is null then order fetch data from id in path
    _news = Provider.of<NewsProvider>(context, listen: false)
        .getNewsById(widget.id)!;
  }

  Future<void> _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final url = Uri.parse(_news.imageURL);
    final imageRes = await http.get(url);

    XFile imageFile = XFile.fromData(imageRes.bodyBytes);

    await Share.shareXFiles(
      [imageFile],
      text: _news.summary,
      subject: _news.title,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

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
                    SerManosText.overline(_news.source,
                        textAlign: TextAlign.left),
                    SerManosText.headline2(_news.title,
                        textAlign: TextAlign.left),
                    const SerManosSizedBox.sl(),
                    Image.network(
                      _news.imageURL,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosText.body1(
                      _news.summary,
                      color: SerManosColors.secondary200,
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosText.body1(_news.description),
                    const SerManosSizedBox.sl(),
                    Center(
                      child: SerManosText.headline1(
                        "Comparte esta nota",
                      ),
                    ),
                    const SerManosSizedBox.sl(),
                    SerManosTextButton.longTextButton(
                      text: 'Compartir',
                      onPressed: () => _onShare(context),
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
