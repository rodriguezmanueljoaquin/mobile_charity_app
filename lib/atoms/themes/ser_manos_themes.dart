import 'package:flutter/material.dart';
import 'package:mobile_charity_app/tokens/colors.dart';
import 'package:mobile_charity_app/tokens/typography.dart';

final ligthThemeSerManos =  ThemeData(
  primaryColor: SerManosColors.primary100,
  fontFamily: SerManosTypography.family,

  textTheme: const TextTheme(
    displayLarge:   TextStyle( //headline1
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeHeading1,
      color: SerManosColors.neutral100,
    ),
    displayMedium: TextStyle( //headline2
      fontWeight: SerManosTypography.mediumFontWeight,
      fontSize: SerManosTypography.fontSizeHeading2,
      color: SerManosColors.neutral100,
    ),
    titleSmall: TextStyle( //subtitle1
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeSubtitle1,
      color: SerManosColors.neutral100,
    ),
    bodyLarge: TextStyle( //bodyText1
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeBody1,
      color: SerManosColors.neutral100,
    ),
    bodyMedium: TextStyle( //bodyText2
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeBody2,
      color: SerManosColors.neutral100,
    ),
    bodySmall: TextStyle( //caption
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeCaption,
      color: SerManosColors.neutral100,
    ), 
    labelLarge: TextStyle( //button
      fontWeight: SerManosTypography.mediumFontWeight,
      fontSize: SerManosTypography.fontSizeButton,
      color: SerManosColors.neutral100,
    ),
    labelSmall: TextStyle( //overline
      fontWeight: SerManosTypography.regularFontWeight,
      fontSize: SerManosTypography.fontSizeOverline,
      color: SerManosColors.neutral100,
    ),
  )
);

