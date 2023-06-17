import 'package:flutter/material.dart';
import 'package:mobile_charity_app/models/news.dart';

import '../api/ser_manos_api.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _news = [];
  bool isLoading = false;

  Future<void> fetchNews() async {
    isLoading = true;

    try {
      _news = await SerManosApi().getNews();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<NewsModel> get news => _news;
}
