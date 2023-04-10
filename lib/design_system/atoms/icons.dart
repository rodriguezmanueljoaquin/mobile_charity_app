import 'package:flutter/material.dart';

class SerManosIcon extends Icon {
  const SerManosIcon.visibility({super.key, required bool state, super.color})
      : super(state ? Icons.visibility : Icons.visibility_off);

  const SerManosIcon.visibilityOutlined(
      {super.key, required bool state, super.color})
      : super(
            state ? Icons.visibility_outlined : Icons.visibility_off_outlined);

  const SerManosIcon.visibilityTwoTone(
      {super.key, required bool state, super.color})
      : super(state
            ? Icons.visibility_sharp
            : Icons
                .visibility_off_sharp); // FIXME: Should be two_tone not sharp, but two_tone is not available

  const SerManosIcon.favorite({super.key, required bool state, super.color})
      : super(state ? Icons.favorite : Icons.favorite_outline);

  const SerManosIcon.search({super.key, super.color}) : super(Icons.search);

  const SerManosIcon.add({super.key, super.color}) : super(Icons.add);

  const SerManosIcon.back({super.key, super.color}) : super(Icons.arrow_back);

  const SerManosIcon.location({super.key, required bool state, super.color})
      : super(state ? Icons.location_on : Icons.location_off);

  const SerManosIcon.locationTwoTone({super.key, super.color})
      : super(Icons
            .location_on_sharp); // FIXME: Should be two_tone not sharp, but two_tone is not available

  const SerManosIcon.close({super.key, super.color}) : super(Icons.close);

  const SerManosIcon.error({super.key, required bool state, super.color})
      : super(state ? Icons.error : Icons.error_outline);

  const SerManosIcon.errorTwoTone({super.key, super.color})
      : super(Icons
            .error_outline_sharp); // FIXME: Should be two_tone not sharp, but two_tone is not available
}
