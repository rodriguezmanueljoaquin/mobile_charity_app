import 'package:flutter/material.dart';
import 'package:mobile_charity_app/models/news.dart';
import 'package:mobile_charity_app/providers/news_provider.dart';

class MockNewsProvider extends ChangeNotifier implements NewsProvider {
  @override
  bool isLoading = false;

  @override
  Future<void> fetchNews() {
    // do nothing
    return Future.value();
  }

  @override
  NewsModel? getNewsById(String id) {
    return _news.first;
  }

  @override
  List<NewsModel> get news => _news;

  final List<NewsModel> _news = [
    NewsModel(
        id: "1",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "2",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "3",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "4",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "5",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "6",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now()),
    NewsModel(
        id: "7",
        title: 'Ser donante voluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
        source: 'Reporte 2820',
        createdAt: DateTime.now())
  ];
}
