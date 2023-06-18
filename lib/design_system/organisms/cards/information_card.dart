import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosInformationCard extends StatefulWidget {
  final String title;
  final Map<String, String> contentsByLabel;

  const SerManosInformationCard({
    super.key,
    required this.title,
    required this.contentsByLabel,
  });

  @override
  State<SerManosInformationCard> createState() =>
      _SerManosInformationCardState();
}

class _SerManosInformationCardState extends State<SerManosInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 328,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: SerManosColors.neutral10,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: SerManosColors.secondary25,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SerManosText.subtitle1(widget.title),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SerManosText.overline(
                          widget.contentsByLabel.entries.elementAt(index).key),
                      SerManosText.body1(widget.contentsByLabel.entries
                          .elementAt(index)
                          .value),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SerManosSizedBox.sm(),
                itemCount: widget.contentsByLabel.length,
              ),
            )
          ],
        ));
  }
}
