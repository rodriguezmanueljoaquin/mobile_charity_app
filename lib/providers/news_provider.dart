import 'package:flutter/material.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/utils/collections.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel>? _news;
  Map<String, int> _newsIndexById = {};

  bool isLoading = false;

  Future<void> fetchNews() async {
    isLoading = true;

    try {
      _news = await SerManosApi().getNews();
      _newsIndexById = listToIndexMapByKey(_news!, (e) => e.id);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<NewsModel>? get news => _news;

  NewsModel? getNewsById(String id) =>
      (_news != null && _newsIndexById[id] != null)
          ? _news![_newsIndexById[id]!]
          : null;
}
