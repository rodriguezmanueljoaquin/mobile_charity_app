import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/tokens/indicators.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';
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

    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SerManosRefreshIndicator(
        onRefresh: Provider.of<NewsProvider>(context).fetchNews,
        child: Consumer<NewsProvider>(
            builder: (context, newsProvider, child) => newsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SerManosSpacing.spaceSL,
                      vertical: SerManosSpacing.spaceLG,
                    ),
                    itemBuilder: (context, index) => UnconstrainedBox(
                      child: SerManosNewsCard(
                        news: newsProvider.news![index],
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SerManosSizedBox.md(),
                    itemCount: newsProvider.news!.length,
                  )));
  }
}
