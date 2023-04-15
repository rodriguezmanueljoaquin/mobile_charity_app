import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';

class SerManosStatusBar extends AppBarTheme {
  const SerManosStatusBar()
      : super(
            systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: SerManosColors.secondary90,
        ));
}
