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

  const SerManosIcon.search(
      {super.key, bool enabled = true, bool isPrimaryAction = false})
      : super(Icons.search,
            color: !enabled
                ? SerManosColors.neutral25
                : isPrimaryAction
                    ? SerManosColors.primary100
                    : SerManosColors.neutral75);

  const SerManosIcon.add({super.key, super.color}) : super(Icons.add);

  const SerManosIcon.back({super.key, super.color}) : super(Icons.arrow_back);

  const SerManosIcon.location(
      {super.key, bool enabled = true, bool isPrimaryAction = false})
      : super(Icons.location_on,
            color: !enabled
                ? SerManosColors.neutral25
                : isPrimaryAction
                    ? SerManosColors.primary100
                    : SerManosColors.neutral75);

  const SerManosIcon.locationOutline(
      {super.key, required bool state, super.color})
      : super(state ? Icons.location_on_outlined : Icons.location_off_outlined);

  const SerManosIcon.close(
      {super.key, bool enabled = true, bool isPrimaryAction = false})
      : super(Icons.calendar_today,
            color: !enabled
                ? SerManosColors.neutral25
                : isPrimaryAction
                    ? SerManosColors.primary100
                    : SerManosColors.neutral75);

  const SerManosIcon.error({super.key})
      : super(Icons.error, color: SerManosColors.error100);

  const SerManosIcon.errorOutline({super.key})
      : super(Icons.error_outline, color: SerManosColors.error100);

  const SerManosIcon.person(
      {super.key, bool enabled = true, bool isPrimaryAction = false})
      : super(Icons.person,
            color: !enabled
                ? SerManosColors.secondary80
                : isPrimaryAction
                    ? SerManosColors.secondary200
                    : SerManosColors.neutral75);

  const SerManosIcon.calendar(
      {super.key, bool enabled = true, bool isPrimaryAction = false})
      : super(Icons.calendar_today,
            color: !enabled
                ? SerManosColors.neutral25
                : isPrimaryAction
                    ? SerManosColors.primary100
                    : SerManosColors.neutral75);
}
