import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/empty_list_placeholder_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/tokens/indicators.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
import 'package:mobile_charity_app/utils/handle_exception.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({
    super.key,
  });

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab>
    with AutomaticKeepAliveClientMixin<NewsTab> {
  @override
  void initState() {
    super.initState();

    NewsProvider newsProvider =
        Provider.of<NewsProvider>(context, listen: false);
    if (newsProvider.news == null) {
      newsProvider.fetchNews().catchError(
          (error) => handleException(context: context, error: error));
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SerManosRefreshIndicator(
      onRefresh: () => Provider.of<NewsProvider>(context, listen: false)
          .fetchNews()
          .catchError(
              (error) => handleException(context: context, error: error)),
      child: Consumer<NewsProvider>(builder: (context, newsProvider, child) {
        if (newsProvider.isLoading) {
          return const Center(child: SerManosProgressIndicator());
        }

        List<NewsModel>? news = newsProvider.news;

        if (news == null || news.isEmpty) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SerManosSpacing.spaceSL,
                vertical: SerManosSpacing.spaceMD,
              ),
              child: SerManosEmptyListPlaceholderCard(
                text:
                    "Actualmente no hay noticias vigentes. Pronto se irán ircorporando nuevas.",
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: SerManosSpacing.spaceSL,
            vertical: SerManosSpacing.spaceLG,
          ),
          itemBuilder: (context, index) => SerManosNewsCard(
            news: news[index],
          ),
          separatorBuilder: (context, index) => const SerManosSizedBox.md(),
          itemCount: news.length,
        );
      }),
    );
  }
}
