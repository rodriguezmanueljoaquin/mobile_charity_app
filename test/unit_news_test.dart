import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/api/ser_manos_api.dart';
import 'package:mobile_charity_app/api/ser_manos_storage.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';

import 'mocks/mock_news_provider.dart';

void main() {
  test("get news", () async {
    // Populate the fake database.
    final fakeFirestore = FakeFirebaseFirestore();
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[1].toJson());

    SerManosApi().setFirestore(fakeFirestore);

    final fakeStorage = MockFirebaseStorage();
    SerManosStorage().setStorage(fakeStorage);

    NewsProvider newsProvider =
        NewsProvider();
    await newsProvider.fetchNews();
    List<NewsModel>? news =
        newsProvider.news;

    assert(news != null);
    expect(news!.length, 1);
  });
  
  test("get news by id", () async {
    // Populate the fake database.
    final fakeFirestore = FakeFirebaseFirestore();
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[1].toJson());
    String id = await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[0].toJson())
        .then((value) => value.id);
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[2].toJson());
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[3].toJson());
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[4].toJson());
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[5].toJson());
    await fakeFirestore
        .collection('news')
        .add(MockNewsProvider().news[6].toJson());

    SerManosApi().setFirestore(fakeFirestore);

    final fakeStorage = MockFirebaseStorage();
    SerManosStorage().setStorage(fakeStorage);

    NewsProvider newsProvider =
        NewsProvider();
    await newsProvider.fetchNews();
    NewsModel? news =
        newsProvider.getNewsById(id);

    assert(news != null);
    expect(news!.id, id);
    expect(news.title, MockNewsProvider().news[0].title);
    expect(news.description, MockNewsProvider().news[0].description);
    expect(news.imageKey, MockNewsProvider().news[0].imageKey);
  });
}
