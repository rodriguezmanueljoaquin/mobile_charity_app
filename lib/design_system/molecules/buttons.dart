import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosButton extends TextButton {
  SerManosButton.longButton(
      {super.key,
      onPressed,
      onLongPress,
      required String text,
      bool disabled = false,
      filled = true})
      : super(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          child: SizedBox(
            height: 44,
            width: SerManosSizes.sizeLG,
            child: Center(
              child: Text(
                text,
                style: SerManosTextStyle.button(
                  color: disabled
                      ? SerManosColors.neutral50
                      : filled
                          ? SerManosColors.neutral0
                          : SerManosColors.primary100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor:
                filled ? SerManosColors.primary100 : SerManosColors.transparent,
            disabledBackgroundColor: SerManosColors.neutral25,
            foregroundColor:
                filled ? SerManosColors.neutral10 : SerManosColors.neutral25,
          ),
        );

  SerManosButton.shortButton(
      {super.key,
      onPressed,
      onLongPress,
      required String text,
      bool disabled = false})
      : super(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 48,
            width: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SerManosIcon.add(color: SerManosColors.neutral0),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: SerManosTextStyle.button(
                    color: disabled
                        ? SerManosColors.neutral50
                        : SerManosColors.neutral0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: SerManosColors.primary100,
            disabledBackgroundColor: SerManosColors.neutral25,
            foregroundColor: SerManosColors.neutral10,
          ),
        );

  SerManosButton.shortTextButton({
    super.key,
    onPressed,
    onLongPress,
    required String text,
    bool disabled = false,
    bool filled = true,
  }) : super(
          onPressed: disabled ? null : onPressed,
          onLongPress: disabled ? null : onLongPress,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: SerManosSpacing.spaceSM,
              vertical: 12.0,
            ),
            height: null,
            width: null,
            child: Text(
              text,
              style: SerManosTextStyle.button(
                color: disabled
                    ? SerManosColors.neutral50
                    : filled
                        ? SerManosColors.neutral0
                        : SerManosColors.primary100,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor:
                filled ? SerManosColors.primary100 : SerManosColors.transparent,
            disabledBackgroundColor: SerManosColors.neutral25,
            foregroundColor:
                filled ? SerManosColors.neutral10 : SerManosColors.neutral25,
          ),
        );
}

class SerManosIconButton extends IconButton {
  const SerManosIconButton({
    super.key,
    onPressed,
    required Icon icon,
    bool disabled = false,
  }) : super(
          onPressed: disabled ? null : onPressed,
          icon: icon,
          iconSize: SerManosSpacing.spaceMD,
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(),
          hoverColor: SerManosColors.transparent,
          splashColor: SerManosColors.transparent,
          highlightColor: SerManosColors.transparent,
        );
}
