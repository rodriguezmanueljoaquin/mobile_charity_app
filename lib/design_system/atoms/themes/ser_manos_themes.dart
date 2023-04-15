import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

final lightThemeSerManos = ThemeData(
    primaryColor: SerManosColors.primary100,
    fontFamily: SerManosTypography.family,
    textTheme: const TextTheme(
      displayLarge: SerManosTextStyle.headline1(),
      displayMedium: SerManosTextStyle.headline2(),
      titleSmall: SerManosTextStyle.subtitle1(),
      bodyLarge: SerManosTextStyle.body1(),
      bodyMedium: SerManosTextStyle.body2(),
      bodySmall: SerManosTextStyle.caption(),
      labelLarge: SerManosTextStyle.button(),
      labelSmall: SerManosTextStyle.overline(),
    ));
