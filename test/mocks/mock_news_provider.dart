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
        title: 'Ser donante vqweqwdoluntario ',
        description:
            'En un esfuerzo por conqwesfdasdadcienciar sobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenaqwdqwadasdqwedqwesadrio recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd1',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "2",
        title: 'Ser donante voluaweqweqsdqwfaentario ',
        description:
            'En un esfuerzo por concienciar sobwewqdasdasdco de posibles problemas de salud.',
        summary:
            'Desde el Hospitaqwdqwedqsdasdl Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd2',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "3",
        title: 'Ser donante vqwqeqwdfasfagoluntario ',
        description:
            'En un esfuerzo por concienciar sobco deasdqwdasdqwd posibles problemas de salud.',
        summary:
            'Desde el Hospital Ceasdasdasdasdntenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd3',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "4",
        title: 'Ser donante qewqweqwefasfvoluntario ',
        description:
            'En un esfuerzo por concienciar sobco de posiasdasdaweqwdsadbles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd4',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "5",
        title: 'Ser donante volqweqweqweqwfuntario ',
        description:
            'En un esfuerzo por concienciar sobdfasddasdasdqco de posibles problemas de salud.',
        summary:
            'Desde el weqweqweqweHospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd5',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "6",
        title: 'Ser donantsadasdasdasdqweqfqe voluntario ',
        description:
            'En un esfuerzo por concienciar wrqwrqweqweqwesobco de posibles problemas de salud.',
        summary:
            'Desde el Hospital Centenario recdqweqweqweqweqweqwealcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd6',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg'),
    NewsModel(
        id: "7",
        title: 'Ser donante volunqweqweqwrqefasfasdtario ',
        description:
            'En un esfuerzo por concienciar sobco de posasdasdasdasdasdasibles problemas de salud.',
        summary:
            'Desde el<sdasdasdasdasd Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        imageKey:
            'asd7',
        source: 'Reporte 2820',
        createdAt: DateTime.now(),
        downloadImageURL: 'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg')
  ];
}
