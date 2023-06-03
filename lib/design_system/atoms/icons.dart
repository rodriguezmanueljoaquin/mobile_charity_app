import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';

class SerManosIcon extends Icon {
  const SerManosIcon.visibility({super.key, required bool state, super.color})
      : super(state ? Icons.visibility : Icons.visibility_off);

  const SerManosIcon.visibilityOutlined(
      {super.key, required bool state, super.color})
      : super(
            state ? Icons.visibility_outlined : Icons.visibility_off_outlined);

  const SerManosIcon.favorite({super.key, required bool state, super.color})
      : super(state ? Icons.favorite : Icons.favorite_outline);

  const SerManosIcon.search({super.key, super.color}) : super(Icons.search);

  const SerManosIcon.add({super.key, super.color}) : super(Icons.add);

  const SerManosIcon.back({super.key, super.color}) : super(Icons.arrow_back);

  const SerManosIcon.location({super.key, required bool state, super.color})
      : super(state ? Icons.location_on : Icons.location_off);

  const SerManosIcon.close({super.key, super.color}) : super(Icons.close);

  const SerManosIcon.error({super.key})
      : super(Icons.error, color: SerManosColors.error100);

  const SerManosIcon.errorOutline({super.key})
      : super(Icons.error_outline, color: SerManosColors.error100);

  const SerManosIcon.person(
      {super.key, bool enabled = true, bool activated = false})
      : super(Icons.person,
            color: !enabled
                ? SerManosColors.secondary80
                : activated
                    ? SerManosColors.neutral75
                    : SerManosColors.secondary200);

}
