import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/models/news.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: SerManosSpacing.spaceSL,
        vertical: SerManosSpacing.spaceLG,
      ),
      itemBuilder: (context, index) => UnconstrainedBox(
        child: SerManosNewsCard(
            news: NewsModel(
                id: "1",
                title: 'Ser donante voluntario ',
                description:
                    'En un esfuerzo por concienciar sobco de posibles problemas de salud.',
                summary:
                    'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
                imageURL:
                    'https://www.hospitalcentenario.gob.ar/wp-content/uploads/2021/06/Donacion-de-sangre-1.jpg',
                source: 'Reporte 2820',
                createdAt: DateTime.now())),
      ),
      separatorBuilder: (context, index) => const SerManosSizedBox.md(),
      itemCount: 5,
    );
  }
}
