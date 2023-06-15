import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

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
      itemBuilder: (context, index) => const UnconstrainedBox(
        child: SerManosNewsCard(
          overline: 'reporte 2820',
          title: 'Ser donante voluntario',
          body:
              'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
        ),
      ),
      separatorBuilder: (context, index) => const SerManosSizedBox.md(),
      itemCount: 5,
    );
  }
}
