import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';

class SerManosTypography {
  SerManosTypography._();

  //fonts
  static const String family = 'Roboto';
  static const FontWeight regularFontWeight = FontWeight.w400;
  static const FontWeight mediumFontWeight = FontWeight.w500;
  static const FontWeight boldFontWeight = FontWeight.w700;

  static const double fontSizeHeading1 = 24;

  static const double fontSizeHeading2 = 20;
  static const double fontSizeSubtitle1 = 16;
  static const double fontSizeBody1 = 14;
  static const double fontSizeBody2 = 12;
  static const double fontSizeButton = 14;
  static const double fontSizeCaption = 12;
  static const double fontSizeOverline = 10;
}

class SerManosTextStyle extends TextStyle {
  const SerManosTextStyle.headline1({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeHeading1,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.headline2({Color? color})
      : super(
          fontWeight: SerManosTypography.mediumFontWeight,
          fontSize: SerManosTypography.fontSizeHeading2,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.subtitle1({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeSubtitle1,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.body1({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeBody1,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.body2({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeBody2,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.button({Color? color})
      : super(
          fontWeight: SerManosTypography.mediumFontWeight,
          fontSize: SerManosTypography.fontSizeButton,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.caption({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeCaption,
          color: color ?? SerManosColors.neutral100,
        );

  const SerManosTextStyle.overline({Color? color})
      : super(
          fontWeight: SerManosTypography.regularFontWeight,
          fontSize: SerManosTypography.fontSizeOverline,
          color: color ?? SerManosColors.neutral100,
        );
}

class SerManosText extends Text {
  SerManosText.headline1(super.text, {super.key, Color? color, super.textAlign})
      : super(style: SerManosTextStyle.headline1(color: color));

  SerManosText.headline2(super.text, {super.key, Color? color, super.textAlign})
      : super(style: SerManosTextStyle.headline2(color: color));

  SerManosText.subtitle1(super.text, {super.key, Color? color, super.textAlign})
      : super(style: SerManosTextStyle.subtitle1(color: color));

  SerManosText.body1(super.text, {super.key, Color? color, super.textAlign})
      : super(style: SerManosTextStyle.body1(color: color));

  SerManosText.body2(super.text, {super.key, Color? color, super.textAlign})
      : super(style: SerManosTextStyle.body2(color: color));

  SerManosText.button(super.text, {super.key, Color? color})
      : super(style: SerManosTextStyle.button(color: color));

  SerManosText.caption(super.text, {super.key, Color? color})
      : super(style: SerManosTextStyle.caption(color: color));

  SerManosText.overline(String text, {super.key, Color? color})
      : super(text.toUpperCase(),
            style: SerManosTextStyle.overline(color: color));
}
