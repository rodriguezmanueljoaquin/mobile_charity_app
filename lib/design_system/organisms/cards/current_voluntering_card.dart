import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class SerManosCurrentVolunteringCard extends StatelessWidget {
  final String? category;
  final String? title;
  final String volunteeringId;

  const SerManosCurrentVolunteringCard({
    super.key,
    this.title,
    this.category,
    required this.volunteeringId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .pushNamed(SerManosPagesName.volunteeringDetails, pathParameters: {
        "id": volunteeringId,
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: SerManosColors.primary5,
          border: Border.all(
            color: SerManosColors.primary100,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SerManosText.overline(
                    category ?? "",
                    overflow: TextOverflow.ellipsis,
                  ),
                  SerManosText.subtitle1(title ?? "",
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              children: const [
                Center(
                  child: SerManosIcon.location(
                    isPrimaryAction: true,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
