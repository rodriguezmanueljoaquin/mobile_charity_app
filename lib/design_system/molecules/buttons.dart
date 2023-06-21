import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/loading_indicator.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosTextButton extends TextButton {
  SerManosTextButton.longTextButton(
      {super.key,
      onPressed,
      onLongPress,
      required String text,
      bool disabled = false,
      bool loading = false,
      filled = true,
      textColor})
      : super(
          onPressed: (disabled || loading) ? null : onPressed,
          onLongPress: (disabled || loading) ? null : onLongPress,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: filled ? 12 : 6,
            ),
            // width: SerManosSizes.sizeLG,
            child: Center(
              child: Stack(children: [
                Text(
                  text,
                  style: SerManosTextStyle.button(
                    color: disabled
                        ? SerManosColors.neutral50
                        : textColor ??
                            (filled
                                ? SerManosColors.neutral0
                                : SerManosColors.primary100),
                  ),
                  textAlign: TextAlign.center,
                ),
                Visibility(
                    visible: loading,
                    child: const SerManosLoadingIndicator(
                        backgroundColor: SerManosColors.neutral25))
              ]),
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

  SerManosTextButton.shortTextButton({
    super.key,
    onPressed,
    onLongPress,
    required String text,
    bool disabled = false,
    bool filled = true,
    bool loading = false,
    Icon? icon,
  }) : super(
          onPressed: (disabled || loading) ? null : onPressed,
          onLongPress: (disabled || loading) ? null : onLongPress,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: SerManosSpacing.spaceSM,
            ),
            height: null,
            width: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon,
                if (icon != null)
                  const SerManosSizedBox.sm(
                    useWidth: true,
                  ),
                Stack(children: [
                  Text(
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
                  Visibility(
                      visible: loading,
                      child: const SerManosLoadingIndicator(
                          backgroundColor: SerManosColors.neutral25))
                ]),
              ],
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
